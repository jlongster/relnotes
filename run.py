#!/usr/bin/env python
#!/usr/bin/env python
"""%prog [-o|--output-dir] [-c|--channels] [--aurora-suffix] [--beta-suffix] [--esr-suffix]

"""
from argparse import ArgumentParser
import sys
import sqlite3
import os
from datetime import datetime
import jinja2

DEFAULT_CHANNELS = ['Aurora', 'Beta', 'Release']
PRODUCTS = ['Firefox', 'Firefox for mobile']
ESR_PRODUCTS = ['Firefox ESR']

conn = sqlite3.connect('relnotes.sqlite')
c = conn.cursor()
channel_info = {}  

def cache_channels(aurora_suffix, beta_suffix, esr_suffix):
    c.execute('SELECT r.version, r.sub_version, c.channel_name, p.product_name FROM Releases r '
              'LEFT JOIN Channels c ON c.id = r.channel '
              'LEFT JOIN Products p ON p.id = r.product '
              'ORDER BY r.release_date DESC')
    data = c.fetchall()

    for record in data:
        (version, sub_version, channel, product) = record
        if channel not in channel_info:
            channel_info[channel] = {'version': version,
                                     'sub_version': sub_version}
            
        if ('desktop-url' not in channel_info[channel] or
            'mobile-url' not in channel_info[channel]) :
            relname = 'releasenotes'
            version_text = '%s.0' % version
    
            if sub_version != 0:
                version_text += '.%s' % sub_version
            
            if channel == 'Aurora':
                    version_text = version_text + aurora_suffix
                    relname = 'auroranotes'
            elif channel == 'Beta':
                version_text = version_text + beta_suffix
            elif channel == 'ESR':
                version_text = version_text + esr_suffix
            
            if product == 'Firefox ESR':
                channel_info[channel]['desktop-url'] = 'en-US/firefox/%s/%s' % (version_text, relname)
            else:
                channel_info[channel]['mobile-url'] = 'en-US/mobile/%s/%s' % (version_text, relname)
                
            if product == 'Firefox':
                channel_info[channel]['desktop-url'] = 'en-US/firefox/%s/%s' % (version_text, relname)
            else:
                channel_info[channel]['mobile-url'] = 'en-US/mobile/%s/%s' % (version_text, relname)

def publish_channel(product_name, channel_name, out_base, aurora_suffix, beta_suffix, esr_suffix):
    c.execute('SELECT id, product_text FROM Products WHERE product_name=? LIMIT 1', (product_name,))
    (product_id, product_text) = c.fetchone()

    c.execute('SELECT id FROM Channels WHERE channel_name=? LIMIT 1',
              (channel_name,))
    (channel_id,) = c.fetchone() or (None,)

    c.execute('SELECT version, sub_version, release_date, release_text FROM Releases '
              'WHERE product=? AND channel=? '
              'ORDER BY release_date DESC LIMIT 1',
              (product_id, channel_id))
    (version, sub_version, release_date, release_text) = c.fetchone() or (None, None, None, None)
    
    # for esr we just want the security fixes per subversion
    if channel_name == 'ESR':
        c.execute('SELECT Notes.description, Tags.tag_text FROM Notes '
              'LEFT OUTER JOIN Tags ON Notes.tag=Tags.id '
              'WHERE bug_num IS NULL AND '
              '(product IS NULL OR product=?) AND '
              'fixed_in_subversion=? AND '
              '(fixed_in_channel=?) '
              'ORDER BY Tags.sort_num ASC, Notes.sort_num DESC',
              (product_id, sub_version, channel_id))
    else:
        c.execute('SELECT Notes.description, Tags.tag_text FROM Notes '
              'LEFT OUTER JOIN Tags ON Notes.tag=Tags.id '
              'WHERE bug_num IS NULL AND '
              '(product IS NULL OR product=?) AND '
              'fixed_in_version=? AND '
              '(fixed_in_channel IS NULL OR fixed_in_channel<=?) '
              'ORDER BY Tags.sort_num ASC, Notes.sort_num DESC',
              (product_id, version, channel_id))
    whats_new = c.fetchall()

    # TODO to fix this for being able to create release notes earlier
    c.execute('SELECT bug_num,description FROM Notes '
              'WHERE bug_num IS NOT NULL AND '
              '(product IS NULL OR product=?) AND '
              'fixed_in_version=? AND '
              '(fixed_in_channel IS NULL OR fixed_in_channel<=?) '
              'ORDER BY sort_num DESC',
              (product_id, version, channel_id))
    fixed = c.fetchall()

    c.execute('SELECT Notes.bug_num, Notes.description, Notes.fixed_in_version, '
              '  Notes.fixed_in_channel, Notes.first_version, Channels.channel_name FROM Notes '
              'LEFT OUTER JOIN Channels ON Notes.fixed_in_channel=Channels.id '
              'WHERE bug_num IS NOT NULL AND '
              '(product IS NULL OR product=?) AND '
              '(first_version<? OR '
              '  (first_version=? AND '
              '    (first_channel IS NULL OR first_channel<=?))) AND '
              '(fixed_in_version IS NULL OR fixed_in_version>? OR '
              '  (fixed_in_version=? AND fixed_in_channel>?)) '
              'ORDER BY sort_num DESC',
              (product_id, version, version, channel_id, version, version, channel_id))
    known_issues = c.fetchall()
    
    # TODO - Integrating the different release's WN and FR pages into the output

    is_mobile = (product_name == 'Firefox for mobile')

    relname = 'releasenotes'
    version_text = '%s.0' % version

    if sub_version != 0:
	    version_text += '.%s' % sub_version

    real_version_text = version_text

    if channel == 'Aurora':
        version_text = version_text + aurora_suffix
        real_version_text = version_text
        relname = 'auroranotes'
    elif channel == 'Beta':
        version_text = version_text + beta_suffix
        real_version_text = version_text
    elif channel == 'ESR':
        version_text = version_text + esr_suffix
        real_version_text = version_text
        relname = 'releasenotes'
        is_mobile = False

    if is_mobile:
        out_dir = 'en-US/mobile/%s/%s' % (real_version_text, relname)
    else:
        out_dir = 'en-US/firefox/%s/%s' % (real_version_text, relname)
        

    out_file = '%s/index.html' % out_dir

    try:
        os.makedirs(os.path.join(out_base, out_dir));
    except OSError: pass

    env = jinja2.Environment(loader=jinja2.FileSystemLoader('templates'))
    tmpl = env.get_template(channel_name + '.html')

    versions = dict([(i['version'],i) for (ch,i) in channel_info.iteritems()])

    rdate = datetime.strptime(release_date, "%Y-%m-%d")
    release_date = datetime.strftime(rdate, "%B %d, %Y").replace(" 0", " ")

    with file(os.path.join(out_base, out_file), 'w') as f:
        f.write(tmpl.render({'is_mobile': is_mobile,
                             'release_date': release_date,
                             'version_text': version_text,
                             'version': version,
                             'whats_new': whats_new,
                             'fixed': fixed,
                             'known_issues': known_issues,
                             'release_text': release_text,
                             'product_text': product_text,
                             'versions': versions}).encode('utf-8'))

    print 'Done: %s' % os.path.join(out_base, out_file)

if __name__ == '__main__':
    parser = ArgumentParser(__doc__)
    parser.set_defaults(
        output_dir=None,
        channels=DEFAULT_CHANNELS,
        aurora_suffix=None,
        beta_suffix='',
        esr_suffix='',
        )
    parser.add_argument("-o", "--output-dir", dest="output_dir",
            help="specify a location for the generated files to be written to")
    parser.add_argument("-c", "--channels", dest="channels",
            help="comma-separated string of channels to create notes for")
    parser.add_argument("--aurora-suffix", dest="aurora_suffix",
            help="specify a specific suffix for aurora release")
    parser.add_argument("--beta-suffix", dest="beta_suffix",
            help="specify a specific suffix for beta release")
    parser.add_argument("--esr-suffix", dest="esr_suffix",
            help="specify a specific suffix for esr releases")

    options, args = parser.parse_known_args()

    if options.output_dir == None:
        parser.error("Need to provide an output location")
    
    channels = options.channels.split(',')
    
    for channel in channels:
        if channel not in DEFAULT_CHANNELS and channel != 'ESR':
            channels.remove(channel)
        if channel == 'Aurora' and options.aurora_suffix == None:
            parser.error("Need to provide an Aurora suffix")

    cache_channels(options.aurora_suffix, options.beta_suffix, options.esr_suffix)
    
    for channel in channels:
        if channel == 'ESR':
            for product in ESR_PRODUCTS:
                publish_channel(product, channel, 
                    options.output_dir, options.aurora_suffix, 
                    options.beta_suffix, options.esr_suffix)
        else:
            for product in PRODUCTS:
                publish_channel(product, channel, 
                    options.output_dir, options.aurora_suffix, 
                    options.beta_suffix, options.esr_suffix)    
    