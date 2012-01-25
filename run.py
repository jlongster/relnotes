#!/usr/bin/env python

import sys
import sqlite3
import jinja2
import os

conn = sqlite3.connect('relnotes.sqlite')
c = conn.cursor()

products = ['Firefox', 'Firefox for mobile']
channels = ['Aurora', 'Beta', 'Release']

if len(sys.argv) < 3:
    print ('Usage: %s <out_base> <aurora_suffix>\n\n'
           'Example: %s /home/mozilla.com a2' % (sys.argv[0], sys.argv[0]))
    sys.exit(1)

out_base = sys.argv[1]
aurora_suffix = sys.argv[2]
beta_suffix = 'beta'

channel_info = {}

def cache_channels():
    c.execute('SELECT r.version, r.sub_version, c.channel_name FROM Releases r '
              'LEFT JOIN Channels c ON c.id = r.channel '
              'ORDER BY r.release_date ASC')
    data = c.fetchall()

    for record in data:
        (version, sub_version, channel) = record
        channel_info[channel] = {'version': version,
                                 'sub_version': sub_version}

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
              '  Notes.fixed_in_channel, Channels.channel_name FROM Notes '
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

    for ch, vs in channel_info.iteritems():
        relname = 'releasenotes'
        version_text = '%s.%s' % (vs['version'], vs['sub_version'])
        if ch == 'Aurora':
            version_text = version_text + aurora_suffix
            relname = 'auroranotes'
        elif ch == 'Beta':
            version_text = version_text + beta_suffix

        if product == 'Firefox':
            channel_info[ch]['url'] = 'en-US/firefox/%s/%s' % (version_text, relname)
        else:
            channel_info[ch]['url'] = 'en-US/mobile/%s/%s' % (version_text, relname)

    out_dir = channel_info[channel_name]['url']
    out_file = '%s/index.html' % channel_info[channel_name]['url']

    try:
        os.makedirs(os.path.join(out_base, out_dir));
    except OSError: pass

    env = jinja2.Environment(loader=jinja2.FileSystemLoader('templates'))
    tmpl = env.get_template(channel_name + '.html')

    urls = dict([(i['version'],i['url']) for (ch,i) in channel_info.iteritems()])

    with file(os.path.join(out_base, out_file), 'w') as f:
        f.write(tmpl.render({'is_mobile': product_name == 'Firefox for mobile',
                             'release_date': release_date,
                             'version': version_text,
                             'whats_new': whats_new,
                             'fixed': fixed,
                             'known_issues': known_issues,
                             'release_text': release_text,
                             'product_text': product_text,
                             'urls': urls}).encode('utf-8'))

cache_channels()

for product in products:
    for channel in channels:
        publish_channel(product, channel)
