#!/usr/bin/env python

import sqlite3
import jinja2

conn = sqlite3.connect('relnotes.sqlite')
c = conn.cursor()

product_name = 'Firefox'
version = None
channel_name = None

c.execute('SELECT id, product_text FROM Products WHERE product_name=? LIMIT 1', (product_name,))
(product_id, product_text) = c.fetchone()

if not version:
    c.execute('SELECT version FROM Releases WHERE product=? ORDER BY release_date DESC LIMIT 1',
              (product_id,))
    (version,) = c.fetchone() or (None,)

if not channel_name:
    c.execute('SELECT c.channel_name FROM Releases r '
              'LEFT OUTER JOIN Channels c ON r.channel=c.id '
              'WHERE product=? AND version=? '
              'ORDER BY release_date DESC LIMIT 1',
              (product_id, version))
    (channel_name,) = c.fetchone() or (None,)

c.execute('SELECT id FROM Channels WHERE channel_name=? LIMIT 1',
          (channel_name,))
(channel_id,) = c.fetchone() or (None,)

c.execute('SELECT sub_version, release_date, release_text FROM Releases '
          'WHERE product=? AND version=? AND channel=? '
          'ORDER BY release_date DESC LIMIT 1',
          (product_id, version, channel_id))
(sub_version, release_date, release_text) = c.fetchone() or (None, None, None)

version_text = 'v.%s.0%s' % (version, '.%s' % sub_version if sub_version else '')

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
          '  (fixed_in_version=? AND '
          '    (fixed_in_channel IS NULL OR fixed_in_channel>?))) '
          'ORDER BY sort_num DESC',
          (product_id, version, version, channel_id, version, version, channel_id))
known_issues = c.fetchall()

env = jinja2.Environment(loader=jinja2.FileSystemLoader('templates'))
tmpl = env.get_template('aurora.html')
print tmpl.render({'whats_new': whats_new,
                   'fixed': fixed,
                   'known_issues': known_issues}).encode('utf-8')
