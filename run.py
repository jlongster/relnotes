#!/usr/bin/env python

import sys
import sqlite3
import os
from datetime import datetime
import jinja2

conn = sqlite3.connect('relnotes.sqlite')
c = conn.cursor()

PRODUCTS = ['Firefox', 'Firefox for mobile']
ESR_PRODUCTS = ['Firefox ESR']

if len(sys.argv) < 4:
    print ('Usage: %s <out_base> <channel_1,channel_2> <aurora_suffix>\n\n'
           'Example: %s /home/mozilla.com Aurora,Beta,Release,ESR a2' % (sys.argv[0], sys.argv[0]))
    sys.exit(1)

out_base = sys.argv[1]
channels = sys.argv[2].split(',')
aurora_suffix = sys.argv[3]
esr_suffix = 'esr'
beta_suffix = ''

channel_info = {}

def cache_channels():
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
            
        if product == 'Firefox':
            channel_info[channel]['desktop-url'] = 'en-US/firefox/%s/%s' % (version_text, relname)
        else:
            channel_info[channel]['mobile-url'] = 'en-US/mobile/%s/%s' % (version_text, relname)


def publish_channel(product_name, channel_name):
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
        real_version_text = version_text + 'beta'
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

cache_channels()

for channel in channels:
    if channel == 'ESR':
        for product in ESR_PRODUCTS:
            publish_channel(product, channel)
    else:
        for product in PRODUCTS:
            publish_channel(product, channel)    
    