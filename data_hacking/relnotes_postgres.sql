--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.4
-- Started on 2013-05-23 15:13:49 PDT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 173 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 173
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 24587)
-- Name: Channels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Channels" (
    id integer NOT NULL,
    channel_name text NOT NULL
);


ALTER TABLE public."Channels" OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 25335)
-- Name: Notes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Notes" (
    id integer NOT NULL,
    bug_num integer,
    description text NOT NULL,
    first_version integer,
    first_channel integer,
    fixed_in_version integer,
    fixed_in_channel integer,
    tag integer,
    product integer,
    sort_num integer,
    fixed_in_subversion integer
);


ALTER TABLE public."Notes" OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 24606)
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Products" (
    id integer NOT NULL,
    product_name text NOT NULL,
    product_text text
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 24616)
-- Name: Releases; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Releases" (
    id integer NOT NULL,
    product integer NOT NULL,
    channel integer NOT NULL,
    version integer NOT NULL,
    sub_version integer DEFAULT 0 NOT NULL,
    release_date timestamp without time zone NOT NULL,
    release_text text
);


ALTER TABLE public."Releases" OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 24635)
-- Name: Tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Tags" (
    id integer NOT NULL,
    tag_text text NOT NULL,
    sort_num integer
);


ALTER TABLE public."Tags" OWNER TO postgres;

--
-- TOC entry 2221 (class 0 OID 24587)
-- Dependencies: 168
-- Data for Name: Channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Channels" (id, channel_name) FROM stdin;
1	Aurora
2	Beta
3	Release
5	ESR
\.


--
-- TOC entry 2225 (class 0 OID 25335)
-- Dependencies: 172
-- Data for Name: Notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Notes" (id, bug_num, description, first_version, first_channel, fixed_in_version, fixed_in_channel, tag, product, sort_num, fixed_in_subversion) FROM stdin;
0	\N	First revision of the <a href="https://blog.mozilla.org/futurereleases/2012/07/06/bringing-social-to-firefox/">Social API</a> and support for Facebook Messenger	17	\N	17	\N	1	1	800	\N
1	681795	Some users may experience a crash when moving bookmarks	\N	\N	10	\N	\N	1	\N	\N
3	\N	Anti-Aliasing for WebGL is now implemented (see <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=615976">bug 615976</a>)	\N	\N	10	\N	1	\N	\N	\N
14	\N	New &lt;bdi&gt; element for bi-directional text isolation, along with supporting CSS properties (see bugs <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=613149">613149</a> and <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=662288">662288</a>)	\N	\N	10	\N	3	\N	\N	\N
15	\N	The forward button is now hidden until you navigate back	\N	\N	10	\N	1	1	100	\N
17	\N	Inspect tool with content highlighting, includes new CSS Style Inspector	\N	\N	10	\N	5	1	\N	\N
18	\N	Full Screen APIs allow you to build a web application that runs full screen (see the <a href="https://wiki.mozilla.org/Platform/Features/Full_Screen_APIs">feature page</a>)	\N	\N	10	\N	3	1	\N	\N
19	\N	View source syntax highlighting now uses the HTML5 parser (see <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=482921">bug 482921</a>)	\N	\N	11	\N	3	1	\N	\N
20	\N	CSS3 3D-Transforms are now supported (see <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=505115">bug 505115</a>)	\N	\N	10	\N	1	1	\N	\N
22	\N	It's now even easier to set up Firefox Sync - see the "Set up Sync" link on the home tab	\N	\N	10	\N	2	2	\N	\N
23	\N	Accelerated layers are now supported via OpenGL ES	\N	\N	10	\N	1	2	\N	\N
30	573369	If you try to start Firefox using a locked profile, it will crash	10	\N	\N	\N	\N	1	\N	\N
33	668288	Some recent changes in the Google layout and CSS may cause issues in non-webkit browsers like Firefox	10	\N	\N	\N	\N	2	\N	\N
34	665374	Blinking characters in form fields	10	\N	14	\N	\N	2	\N	\N
37	676780	There is an extremely rare case where the browser may become unable to load web pages or close tabs	10	\N	10	\N	\N	2	\N	\N
39	628269	Reloading a page increases the zoom level	10	\N	14	\N	\N	2	\N	\N
41	700835	Mac OS X only - after installing the latest Java release from Apple, Firefox may crash when closing a tab with a Java applet installed	10	\N	10	1	\N	1	1000	\N
42	\N	We've added IndexedDB APIs to more closely match the specification	\N	\N	10	\N	5	\N	\N	\N
44	711900	Under certain conditions, scrolling and text input may be jerky	10	\N	10	\N	\N	1	\N	\N
45	\N	SPDY protocol support for faster page loads is <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=528288#c174">now testable</a>	\N	\N	11	\N	5	\N	\N	\N
46	\N	The <a href="https://developer.mozilla.org/en/DOM/element.outerHTML">outerHTML property</a> is now supported on HTML elements	\N	\N	11	\N	3	\N	\N	\N
47	\N	XMLHttpRequest now <a href="http://developer.mozilla.org/en/HTML_in_XMLHttpRequest">supports HTML parsing</a>	\N	\N	11	\N	5	\N	\N	\N
48	\N	The CSS <a href="https://developer.mozilla.org/en/CSS/text-size-adjust">text-size-adjust property</a> is now supported	\N	\N	11	\N	1	\N	\N	\N
49	\N	Web developers can now visualize a web page in 3D using the <a href="https://hacks.mozilla.org/2011/12/new-developer-tools-in-firefox-11-aurora/">Page Inspector 3D View</a>	\N	\N	11	\N	5	1	950	\N
50	\N	Support for Adobe Flash	\N	\N	14	\N	1	2	825	\N
51	691662	Firefox notifications may not work properly with Growl 1.3 or later	10	\N	11	\N	\N	1	\N	\N
52	\N	Firefox can now migrate your bookmarks, history, and cookies from Google Chrome	\N	\N	11	\N	1	1	1000	\N
55	\N	Redesigned media controls for HTML5 video	\N	\N	11	\N	2	1	\N	\N
56	695565	Firefox for Android uses the same locale as your system language settings	\N	3	999	\N	\N	2	\N	\N
59	705201	Forms are not yet fully functional	12	\N	15	\N	\N	2	\N	\N
60	710808	Some text may appear too large	12	\N	14	1	\N	2	\N	\N
61	711515	Opening links from external apps may not open properly.	12	\N	14	1	\N	2	\N	\N
62	697858	Your previous tab session may not be re-opened on launch in some instances	12	\N	14	1	\N	2	\N	\N
63	\N	The user interface has been completely re-designed with a new Awesome Screen	\N	\N	14	\N	1	2	950	\N
64	\N	New personalized Start Page with top sites and tabs from last time	\N	\N	14	\N	1	2	850	\N
65	\N	Fonts are resized for better readability	12	\N	\N	\N	1	2	\N	\N
66	\N	Top Sites, Bookmarks, and History are now even more accessible from the Awesome Bar	\N	\N	14	\N	2	2	\N	\N
69	\N	Faster start-up and page load times	\N	\N	14	\N	1	2	1000	\N
70	\N	Files can now be stored in IndexedDB (see <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=661877">bug 661877</a>)	\N	\N	11	\N	5	\N	\N	\N
71	\N	Websockets has now been unprefixed	\N	\N	11	\N	5	\N	\N	\N
72	\N	The <a href="https://hacks.mozilla.org/2011/12/new-developer-tools-in-firefox-11-aurora/">Style Editor</a> for CSS editing is now available to web developers	\N	\N	11	\N	5	1	1000	\N
75	\N	Most add-ons are now compatible with new versions of Firefox by default	\N	\N	10	2	1	1	2000	\N
76	\N	With Sync enabled, add-ons can now be synchronized across your computers	\N	\N	11	\N	1	1	100	\N
77	715396	Silverlight video may not play on some Macintosh hardware	9	\N	10	\N	\N	1	\N	\N
78	690287	Two-digit browser version numbers may cause a small number of <a href="https://hacks.mozilla.org/2012/01/firefox-goes-2-digit-time-to-check-your-ua-sniffing-scripts/">website incompatibilities</a>	10	\N	10	\N	\N	1	50	\N
79	\N	URLs pasted into the download manager window are now automatically downloaded	\N	\N	12	\N	2	1	\N	\N
80	\N	Line breaks are now supported in the title attribute	\N	\N	12	\N	2	\N	\N	\N
83	\N	Smooth scrolling is now enabled by default	\N	\N	13	\N	2	1	\N	\N
84	\N	Windows: Firefox is now easier to update with one less prompt (User Account Control)	\N	\N	12	\N	1	1	500	\N
85	\N	Improvements to "Find in Page" to center search result	\N	\N	12	\N	2	1	\N	\N
86	\N	The <a href="https://developer.mozilla.org/en/CSS/column-fill">column-fill</a> CSS property has been implemented	\N	\N	13	\N	5	\N	\N	\N
87	\N	Support for the <a href="https://developer.mozilla.org/en/CSS/text-align-last">text-align-last</a> CSS property has been added	\N	\N	12	\N	5	\N	\N	\N
88	\N	Experimental support for ECMAScript 6 <a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Map">Map</a> and <a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Set">Set</a> objects has been implemented	\N	\N	13	\N	5	\N	\N	\N
91	\N	Page Source now has line numbers	\N	\N	12	\N	1	1	50	\N
158	736073	14.0.1: Screen locks while Flash videos playing	\N	\N	14	\N	\N	2	\N	1
92	\N	Java applets sometimes caused text input to become unresponsive (<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=718939">bug 718939</a>)	\N	\N	10	3	4	1	\N	\N
93	\N	Security fixes can be <a href="https://www.mozilla.org/security/known-vulnerabilities/firefox.html">found here</a>.	\N	\N	10	3	4	\N	50	\N
94	711388	Web workers would sometimes run out of memory, affecting some add-ons used by organizations	\N	\N	10	\N	4	\N	\N	3
95	\N	Security fixes can be found <a href="https://www.mozilla.org/security/known-vulnerabilities/firefoxESR.html">here</a>	\N	\N	10	5	4	3	50	4
97	\N	Restored background tabs are not loaded by default for faster startup	\N	\N	13	\N	2	1	\N	\N
98	\N	When opening a new tab, users are now presented with their most visited pages	\N	\N	13	\N	1	1	150	\N
99	\N	The default home page now has quicker access to bookmarks, history, settings, and more	\N	\N	13	\N	1	1	\N	\N
101	\N	SPDY protocol now enabled by default for faster browsing on supported sites	\N	\N	13	\N	2	\N	\N	\N
102	\N	Support for the CSS3 <a href="https://developer.mozilla.org/en/CSS/background-position">background-position</a> property extended syntax has been added	\N	\N	13	\N	5	\N	\N	\N
103	\N	The <a href="https://developer.mozilla.org/en/CSS/%3Ainvalid">:invalid</a> pseudo-class can now be applied to the <form> element	\N	\N	13	\N	5	\N	\N	\N
104	\N	The CSS turn <a href="https://developer.mozilla.org/en/CSS/angle">&lt;angle&gt;</a> unit is now supported	\N	\N	13	\N	5	\N	\N	\N
106	713305	OS X: WebGL performance may be degraded on some hardware	11	\N	12	\N	\N	1	\N	\N
107	\N	Security fixes can be found <a href="https://www.mozilla.org/security/known-vulnerabilities/firefoxESR.html">here</a>	\N	\N	10	\N	4	\N	\N	3
108	\N	Various <a href="https://www.mozilla.org/security/known-vulnerabilities/firefox.html">security fixes</a>	\N	\N	12	\N	4	\N	\N	\N
109	\N	<a href="http://hacks.mozilla.org/2012/03/firefox-aurora-13-developer-tools-updates/">72 total improvements</a> to Page Inspector, HTML panel, Style Inspector, Scratchpad and Style Editor	\N	\N	13	\N	5	1	50	\N
110	739141	Some TinyMCE-based editors failed to load	11	\N	12	\N	\N	\N	\N	\N
111	737535	Firefox ESR 10.0.3 opened "Whats New" page after update	\N	\N	10	5	4	3	\N	4
112	734848	extensions.checkCompatibility.* prefs don't work as expected in ESR releases (	\N	\N	10	5	4	3	\N	4
113	\N	Google searches <a href="https://blog.mozilla.org/futurereleases/2012/05/09/rolling-out-https-google-search/">now utilize HTTPS</a>	\N	\N	14	\N	1	\N	\N	\N
114	\N	 <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=639705">Full screen support</a> for Mac OS X Lion implemented	\N	\N	14	\N	1	1	\N	\N
116	\N	Tap-to-play is default for plugins	\N	\N	14	\N	1	2	50	\N
117	\N	Improved site identity manager, to <a href="http://blog.mozilla.org/ux/2012/06/site-identity-ui-updates/">prevent spoofing</a> of an SSL connection with favicons	\N	\N	14	\N	2	1	\N	\N
118	\N	The Awesome Bar now <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=566489">auto-completes typed URLs</a>	\N	\N	14	\N	1	1	\N	\N
119	\N	<a href="https://developer.mozilla.org/en/API/Pointer_Lock_API ">Pointer Lock API</a> implemented	\N	\N	14	\N	5	\N	\N	\N
120	\N	New API to <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=697132">prevent your display from sleeping</a>	\N	\N	14	\N	5	\N	\N	\N
122	\N	New text-transform and font-variant <a href="https://developer.mozilla.org/en/Firefox_14_for_developers#CSS">CSS improvements</a> for Turkic languages and Greek	\N	\N	14	\N	5	\N	\N	\N
124	720987	Focus rings keep growing when repeatedly tabbing through elements	14	\N	15	\N	\N	1	\N	\N
125	743598	GIF animation can gets stuck when src and image size are changed	14	\N	14	\N	\N	\N	\N	\N
126	\N	New panning/zooming architecture implemented for better touch responsiveness	\N	\N	14	\N	1	2	\N	\N
127	\N	Better text readability through font size inflation	\N	\N	14	\N	1	2	810	\N
128	703056	Flash is not currently supported on Tegra 2 devices running Gingerbread	14	\N	14	\N	\N	2	\N	\N
129	736123	WebGL on Adreno devices is not currently supported	14	\N	15	\N	\N	2	\N	\N
131	707195	Font inflation may sometimes render inconsistent font sizes on certain pages	14	\N	\N	\N	\N	2	\N	\N
132	727421	Full screen does not work correctly on Flash video	14	\N	14	\N	\N	2	\N	\N
133	695172	Find on page is not currently supported	\N	\N	\N	\N	\N	2	\N	\N
136	761206	Firefox Sync will not behave as expected if multiple Firefox channels are installed on a single device	14	\N	\N	\N	\N	2	\N	\N
137	750511	Holding the Galaxy Note's stylus close to the phone dismisses the virtual keyboard on the Awesome Screen	14	\N	14	\N	\N	2	\N	\N
138	758885	CSS :hover regression when an element's class name is set by Javascript	13	\N	14	\N	\N	1	\N	\N
139	752149	OS X: nsCocoaWindow::ConstrainPosition uses wrong screen in multi-display setup	12	\N	14	\N	\N	1	\N	\N
140	\N	Preliminary native PDF support (Aurora/Beta only)	\N	\N	\N	\N	1	1	100	\N
141	\N	Optimized memory usage for add-ons	\N	\N	15	\N	2	1	\N	\N
142	\N	New layout view added to Inspector	\N	\N	15	\N	5	1	25	\N
143	\N	JavaScript debugger integrated into developer tools	\N	\N	15	\N	5	1	50	\N
144	\N	New responsive design tool allows web developers to switch between desktop and mobile views of sites	\N	\N	15	\N	5	1	\N	\N
145	\N	Find in page implemented	\N	\N	15	\N	1	2	60	\N
146	\N	Pause, resume, cancel, and retry options added to the download manager	\N	\N	15	\N	2	2	\N	\N
147	\N	<a href="https://hacks.mozilla.org/2012/08/opus-support-for-webrtc">Native support</a> for the Opus audio codec added	\N	\N	15	\N	3	\N	\N	\N
148	\N	Support for SPDY networking protocol v3	\N	\N	15	\N	1	\N	50	\N
149	\N	The <a href="https://developer.mozilla.org/en/HTML/Element/source">&lt;source&gt;</a>  element now supports the media attribute	\N	\N	15	\N	3	\N	\N	\N
150	\N	The <a href="https://developer.mozilla.org/en/HTML/Element/audio">&lt;audio&gt;</a> and <a href="https://developer.mozilla.org/en/HTML/Element/video">&lt;video&gt;</a> elements now support the played attribute	\N	\N	15	\N	3	\N	\N	\N
151	\N	The CSS <a href="https://developer.mozilla.org/en/CSS/word-break">word-break</a> property has been implemented.	\N	\N	15	\N	5	\N	\N	\N
152	764546	Windows Messenger would not load in Hotmail, and the Hotmail inbox would not auto-update	13	\N	13	\N	\N	1	\N	\N
153	756850	Hebrew text would sometimes render incorrectly	13	\N	13	\N	\N	1	\N	\N
154	747683	Flash 11.3 sometimes causes a crash on quit	13	\N	13	\N	\N	1	\N	\N
156	\N	14.0.1: Various stability and performance fixes	\N	\N	14	\N	4	2	\N	1
157	769269	14.0.1: "Don't keep activities" Android 4.x developer option prevents pages from loading	\N	\N	14	\N	\N	2	\N	1
159	758361	14.0.1: Zooming resets once page is fully loaded	\N	\N	14	\N	\N	2	\N	1
160	765150	14.0.1: Purple screen when playing HTML5 videos on some Motorola devices	\N	\N	14	\N	\N	2	\N	1
161	\N	Various <a href="https://www.mozilla.org/security/known-vulnerabilities/firefox.html">security fixes</a>	\N	\N	14	\N	4	\N	\N	1
162	\N	High precision event timer implemented	\N	\N	15	\N	5	\N	\N	\N
163	\N	WebGL enhancements, including compressed textures for better performance 	\N	\N	15	\N	1	1	30	\N
164	\N	Native UI for tablets, including faster startup and a beautiful new Awesome Bar!	\N	\N	15	\N	1	2	500	\N
165	\N	Desktop sites can now be requested from the menu	\N	\N	15	\N	1	2	400	\N
166	\N	Even better tabs experience - now includes swipe to close	\N	\N	15	\N	1	2	300	\N
167	\N	Specific types of private data can now be cleared from the Settings	\N	\N	15	\N	2	2	\N	\N
168	\N	Bookmarks and history can now be imported from the stock browser in the Settings	\N	\N	15	\N	1	2	\N	\N
169	\N	Initial <a href="https://developer.mozilla.org/en-US/docs/Apps/Getting_Started">web app support</a> (Windows/Mac/Linux)	\N	\N	16	\N	1	1	100	\N
170	\N	Firefox on Mac OS X now has preliminary VoiceOver support turned on by default	\N	\N	16	\N	1	1	200	\N
171	650355	No longer supporting MD5 as a hash algorithm in digital signatures 	\N	\N	16	\N	1	\N	\N	\N
173	772341	Opus support by default	\N	\N	16	\N	2	\N	\N	\N
174	687724	Per tab reporting in about:memory	\N	\N	16	\N	2	1	\N	\N
175	\N	CSS3 Animations, Transitions, Transforms and Gradients <a href="https://hacks.mozilla.org/2012/07/aurora-16-is-out/">unprefixed in Firefox 16</a>	\N	\N	16	\N	5	\N	400	\N
176	655920	Reverse animation direction has been implemented	\N	\N	16	\N	5	1	\N	\N
177	\N	New Developer Toolbar with buttons for quick access to tools, error count for the Web Console, and a new command line for quick keyboard access	\N	\N	16	\N	5	1	600	\N
178	\N	Recently opened files list in Scratchpad implemented	\N	\N	16	\N	5	1	\N	\N
179	728831	User Agent strings for pre-release Firefox versions now show only major version	\N	\N	16	\N	5	1	\N	\N
181	769150	Pointer lock doesn't work in web apps	16	\N	17	2	\N	1	\N	\N
182	770409	PDF files hang while loading	\N	\N	\N	\N	\N	1	\N	\N
183	767779	Animated gif stops animating	\N	\N	\N	\N	\N	1	\N	\N
184	695173	Support for text selection in static web content	\N	\N	16	\N	1	2	\N	\N
186	770047	Quick black screen flash on startup with 4.1 (Jelly Bean)	14	\N	15	\N	\N	2	\N	\N
187	770291	Holding backspace may delete text both in front of and behind the cursor	14	\N	19	\N	4	2	\N	\N
189	\N	Reader Mode implemented for easy readability - just tap the book icon next to the URL	\N	\N	16	\N	1	2	400	\N
191	769893	14.0.2: JellyBean pinch-to-zoom crashiness	\N	\N	14	\N	4	2	500	2
192	\N	Silent, background updates	15	\N	15	\N	1	1	1000	\N
193	783393	Debugger breakpoints do not catch on page reload	15	\N	16	2	\N	1	500	\N
194	784757	Kyocera Echo temporarily de-supported due to stability issues	15	\N	16	2	\N	2	500	\N
195	695173	Basic support for text selection in web content (static text areas)	\N	\N	15	\N	\N	2	400	\N
196	770928	Copy/paste functionality restored	14	\N	15	\N	\N	2	300	\N
197	674770	Contenteditable breaks middle-click to open links	\N	\N	10	5	\N	\N	\N	7
198	452781	Allow specifying wildcard that matches all simple netbiosnames in network.automatic-ntlm-auth.trusted-uris	\N	\N	10	5	\N	3	\N	7
199	\N	Localization in Maithili <a href="http://www.mozilla.org/en-US/firefox/all.html">(see all available locales)</a>	15	\N	15	\N	1	1	10	\N
200	\N	Enhanced Search in the Firefox Awesomebar (<a href="http://ianbarlow.wordpress.com/2012/03/09/enhanced-search-in-the-firefox-awesomebar/">blog post</a>	15	\N	15	\N	\N	2	300	\N
202	\N	Use the "Share" menu item to send tabs to desktop/mobile devices through the "Firefox Sync" option	\N	\N	16	\N	1	2	\N	\N
203	\N	Improvements around JavaScript responsiveness through <a href="https://blog.mozilla.org/javascript/2012/08/28/incremental-gc-in-firefox-16/">incremental garbage collection</a>	\N	\N	16	\N	2	\N	\N	\N
204	\N	Acholi and Kazakh localizations added	\N	\N	16	\N	1	1	\N	\N
205	\N	Updated Awesome Bar experience with larger icons	\N	\N	17	\N	2	1	500	\N
206	\N	<a href="https://developer.mozilla.org/en-US/docs/HTML/Element/iframe#attr-sandbox">Sandbox</a> attribute for iframes implemented, enabling increased security	\N	\N	17	\N	3	\N	\N	\N
207	\N	SVG FillPaint and StrokePaint implemented 	\N	\N	17	\N	5	\N	\N	\N
208	780345	Page scrolling on sites with fixed headers	17	\N	17	\N	4	1	\N	\N
209	\N	Over twenty performance improvements, including fixes around the New Tab page	\N	\N	17	\N	4	1	\N	\N
210	\N	New Markup panel in the Page Inspector allows easy editing of the DOM	\N	\N	17	\N	5	1	\N	\N
211	\N	Improvements that make the Web Console, Debugger and Developer Toolbar faster and easier to use	\N	\N	17	\N	5	1	\N	\N
213	\N	Android 4/4.1: hardware and software decoder support for h.264 video	\N	\N	17	\N	1	2	\N	\N
214	\N	Initial web app support	\N	\N	17	\N	1	2	\N	\N
215	\N	Jellybean support for Explore by Touch	\N	\N	17	\N	1	2	\N	\N
216	\N	JavaScript Maps and Sets are now iterable	\N	\N	17	\N	5	\N	\N	\N
218	787743	Sites visited while in Private Browsing mode could be found through manual browser cache inspection	\N	\N	15	3	4	1	500	1
219	780543	Holding backspace causes enormous repeats of content	15	3	15	3	4	2	500	1
220	\N	tel: URLs crafted to maliciously wipe your phone can no longer be opened	\N	\N	16	\N	1	2	\N	\N
221	\N	Click-to-play blocklisting implemented to prevent vulnerable plugin versions from running without the user's permission (see <a href="http://blog.mozilla.org/addons/2012/10/11/click-to-play-coming-firefox-17/">blog post</a>)	17	\N	17	\N	1	1	\N	\N
222	\N	Support for Retina Display on OS X 10.7 and up	\N	\N	18	\N	1	1	950	\N
223	\N	Experience better image quality with our new HTML scaling algorithm 	\N	\N	18	\N	2	1	900	\N
224	62178	Disable insecure content loading on HTTPS pages through an about:config pref	\N	\N	18	\N	\N	\N	500	\N
225	\N	Support for new DOM property window.devicePixelRatio	\N	\N	18	\N	5	\N	500	\N
226	\N	Support for W3C touch events implemented, taking the place of MozTouch events	\N	\N	18	\N	3	1	750	\N
227	\N	Support for <a href="http://143th.net/post/32874476488/transferable-objects-for-ff">Transferable objects</a> 	\N	\N	18	\N	4	\N	300	\N
228	\N	<a href="https://developer.mozilla.org/en-US/docs/CSS/Using_CSS_flexible_boxes?redirectlocale=en-US&redirectslug=CSS%2FFlexbox">CSS3 Flexbox</a> implemented and enabled by default	\N	\N	22	\N	5	\N	1000	\N
229	\N	Improvement in startup time through smart handling of signed extension certificates	\N	\N	18	\N	5	1	\N	\N
232	\N	Performance improvements around tab switching	\N	\N	18	\N	2	1	500	\N
235	586885	Opt-in for search suggestions when entering text into the Awesome Bar	\N	\N	18	\N	2	2	\N	\N
236	\N	Integration with Google Now search widget	\N	\N	18	\N	1	2	900	\N
237	\N	<a href="http://www.morbo.org/2012/10/phishing-protection-on-mobile.html">Safe Browsing enabled</a>	\N	\N	18	\N	1	2	900	\N
238	\N	Support for loading new fonts delivered with Firefox	\N	\N	18	\N	2	2	500	\N
241	\N	16.0.1: Vulnerability outlined <a href="https://blog.mozilla.org/security/2012/10/10/security-vulnerability-in-firefox-16/">here</a>	\N	\N	16	\N	4	\N	\N	1
242	\N	16.0.1: CyanogenMod 10 stability issues	\N	\N	16	\N	4	2	\N	1
243	\N	Preliminary support for WebRTC	\N	\N	18	\N	1	1	100	\N
244	769764	Improved responsiveness for users on proxies	18	\N	18	\N	4	1	\N	\N
245	\N	Support for ARMv6 phones with at least 800MHZ processor and minimum 512MB RAM	17	\N	17	\N	1	2	500	\N
246	\N	Profile size reduction and IO improvements due to SafeBrowsing	17	\N	17	\N	1	2	\N	\N
248	802274	Starting Firefox with -private flag incorrectly claims you are not in Private Browsing mode	18	\N	19	\N	\N	1	\N	\N
249	811657	Android 4.2 instability	16	\N	17	\N	4	2	\N	\N
250	812480	Android 4.2: TalkBack announces that a page finished loading only after one touches the display	17	\N	18	\N	\N	2	\N	\N
251	\N	Built-in PDF viewer	\N	\N	19	\N	1	1	\N	\N
252	\N	Mac OS X 10.5 is <a href="https://blog.mozilla.org/futurereleases/2012/10/04/we-bid-you-adieu-spotted-cat/">no longer supported</a>	\N	\N	17	\N	2	1	\N	\N
254	\N	Added theme support	\N	\N	19	\N	1	2	\N	\N
255	\N	Lowered minimum CPU requirement to 600MHz	\N	\N	19	\N	2	2	\N	\N
257	\N	Startup performance improvements (<a href="https://bugzilla.mozilla.org/buglist.cgi?quicksearch=715402%2C756313">bugs 715402 and 756313</a>)	\N	\N	19	\N	2	1	\N	\N
258	\N	CSS <a href="https://developer.mozilla.org/en-US/docs/CSS/length#Viewport-percentage_lengths">viewport-percentage length units</a> implemented (vh, vw, vmin and vmax)	\N	\N	19	\N	3	\N	\N	\N
259	\N	CSS text-transform now supports <a href="https://developer.mozilla.org/en-US/docs/CSS/text-transform">full-width</a>	\N	\N	19	\N	3	\N	\N	\N
260	\N	CSS <a href="https://developer.mozilla.org/en-US/docs/CSS/@page">@page</a> is now supported	\N	\N	19	\N	3	\N	\N	\N
261	\N	Canvas elements can export their content as an image blob using <a href="https://hacks.mozilla.org/2012/10/firefox-development-highlights-viewport-percentage-canvas-toblob-and-webrtc/">canvas.toBlob()</a>	\N	\N	19	\N	2	\N	\N	\N
262	\N	Remote Web Console is available for connecting to Firefox on Android or Firefox OS (experimental, set devtools.debugger.remote-enabled to true)	\N	\N	19	\N	5	1	\N	\N
263	\N	Web Console CSS links now open in the Style Editor	\N	\N	19	\N	5	1	\N	\N
264	\N	Debugger now supports pausing on exceptions and hiding non-enumerable properties	\N	\N	19	\N	5	1	\N	\N
265	\N	There is now a Browser Debugger available for add-on and browser developers (experimental, set devtools.chrome.enabled to true)	\N	\N	19	\N	5	1	\N	\N
266	\N	17.0.1: Font rendering issue in Firefox 17.0 (<a href="http://bugzil.la/814101">bug 814101</a>)	17	\N	17	3	4	1	500	1
267	\N	17.0.1: Reverted user agent change causing some website incompatibilities	17	\N	17	3	4	1	400	1
268	815042	17.0.1: Leaving Private Browsing with Social API enabled should reset social components	17	3	17	3	4	1	300	1
269	\N	Faster JavaScript performance via IonMonkey compiler	\N	\N	18	\N	1	\N	1000	\N
270	825734	Plugins stop rendering when the top half of the plugin is scrolled off the top of the page, in HiDPI mode	18	\N	19	\N	\N	1	\N	\N
271	825205	Certain valid WebGL drawing operations are incorrectly rejected,\nleaving incomplete rendering in affected pages	18	\N	19	\N	\N	\N	\N	\N
272	\N	Support for Traditional Chinese and Simplified Chinese localizations	\N	\N	19	\N	1	2	\N	\N
273	\N	Per-window Private Browsing. <a href="https://support.mozilla.org/en-US/kb/private-browsing-browse-web-without-saving-info">Learn more</a>.	20	\N	20	\N	1	1	1000	\N
274	\N	New download experience. <a href="https://support.mozilla.org/en-US/kb/find-and-manage-downloaded-files?esab=a&s=download+manager&r=0&as=s#os=mac&browser=fx20">Learn more</a>.	20	\N	20	\N	1	1	900	\N
275	\N	Ability to close hanging plugins, without the browser hanging	\N	\N	20	\N	1	1	500	\N
276	\N	Continued performance improvements around common browser tasks (<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=792438">page loads</a>, <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=789932">downloads</a>, <a href="https://bugzilla.mozilla.org/buglist.cgi?quicksearch=818296%2C818739">shutdown</a>, etc.)	\N	\N	20	\N	2	1	\N	\N
277	\N	New JavaScript Profiler tool	\N	\N	20	\N	5	1	\N	\N
278	\N	Per-tab private browsing	\N	\N	20	\N	1	2	1000	\N
279	\N	Gingerbread and Honeycomb support for H.264/AAC/MP3 hardware decoders	\N	\N	20	\N	1	2	\N	\N
280	\N	System requirements have been lowered to 384MB of RAM and QVGA displays	\N	\N	20	\N	2	2	\N	\N
281	\N	Continued implementation of draft ECMAScript 6 - <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=814562">clear()</a> and <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=808148">Math.imul</a>	\N	\N	20	\N	5	\N	\N	\N
282	\N	getUserMedia implemented for web access to the user's camera and microphone (with user permission)	\N	\N	20	\N	3	1	500	\N
283	\N	&lt;canvas&gt; now supports <a href="https://hacks.mozilla.org/2012/12/firefox-development-highlights-per-window-private-browsing-canvas-globalcompositeoperation-new-values/">blend modes</a>	\N	\N	20	\N	3	\N	\N	\N
284	\N	Various &lt;audio&gt; and &lt;video&gt; <a href="http://blog.pearce.org.nz/2012/12/html5-video-playbackrate-and-ogg.html">improvements</a>	\N	\N	20	\N	3	\N	\N	\N
286	\N	Animated Personas or Themes now require a workaround. See <a href = "https://support.mozilla.org/en-US/kb/animated-persona-stops-working">this support page</a>)	18	\N	\N	\N	\N	1	\N	\N
287	\N	18.0.1 Problems involving HTTP Proxy Transactions (<a href="http://bugzil.la/828632">bug 828632,</a><a href="http://bugzil.la/828202">bug 828202,</a></a><a href="http://bugzil.la/828202">bug 828202,</a></a><a href="http://bugzil.la/829646">bug 829646,</a>)	18	\N	18	3	4	1	1500	1
288	\N	18.0.1 Unity player crashes on Mac OS X (<a href="http://bugzil.la/828954">bug 828954</a>)	18	\N	18	3	4	1	1400	1
289	\N	18.0.1 Disabled HIDPI support only on external monitors to avoid rendering glitches (<a href="http://bugzil.la/ 814434">bug  814434</a>)	18	\N	18	3	4	1	1300	1
290	\N	18.0.2: Fix JavaScript related stability issues	18	\N	18	3	4	1	1500	1
291	824483	Tablets - home tab thumbnails may appear cut off	19	\N	20	\N	\N	2	\N	\N
292	833719	Some function keys may not work when pressed	19	\N	21	\N	\N	1	\N	\N
293	\N	Enhanced <a href="https://blog.mozilla.org/privacy/2013/01/28/newdntui/">three-state UI for Do Not Track (DNT) </a>\n	\N	\N	21	\N	1	1	900	\N
294	\N	Shipping <a href="https://blog.mozilla.org/ux/2013/03/improved-type-on-firefox-for-android/">Open Sans and Charis</a> fonts for Web Content	\N	\N	21	\N	1	2	1000	\N
295	\N	Removed <a href="https://developer.mozilla.org/en-US/docs/E4X">E4X</a> support from Spidermonkey	\N	\N	21	\N	2	\N	\N	\N
296	\N	Implemented <a href="http://updates.html5rocks.com/2012/03/A-New-Experimental-Feature-style-scoped">scoped stylesheets</a> 	\N	\N	21	\N	3	\N	\N	\N
298	\N	Added support for <a href=" https://developer.mozilla.org/en-US/docs/HTML/Element/main">&lt;main&gt;</a> element	\N	\N	21	\N	3	\N	1000	\N
299	\N	DOM/content implemententation for &lt;input type='time'&gt; <a href="https://bugzilla.mozilla.org/buglist.cgi?quicksearch=777283%2C781569%2C781570%2C781572%2C781573%2C;list_id=5727927">Associated bugs</a>	\N	\N	21	\N	5	2	\N	\N
300	\N	Ability to restore removed thumbnails on New tab Page	\N	\N	21	\N	2	1	500	\N
301	\N	Preliminary implementation of Firefox Health Report <a href="https://blog.mozilla.org/metrics/fhr-faq/">(see FAQ)</a>	\N	\N	21	\N	1	1	1000	\N
302	\N	Firefox will suggest how to improve your application startup time if needed	\N	\N	21	\N	1	1	500	\N
303	\N	Integrated, Add-on SDK loader and API libraries into Firefox	\N	\N	21	\N	5	\N	\N	\N
304	\N	Polished UI based on Holo theme	\N	\N	21	\N	2	2	1000	\N
305	\N	Top Sites in about:home are now customizable	\N	\N	20	\N	1	2	\N	\N
306	777639	Download Manager page is not updated after clearing private data	\N	\N	21	\N	4	2	\N	\N
307	\N	Graphics related performance improvements (<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=809821">bug 809821</a>)	\N	\N	21	\N	2	\N	\N	\N
308	\N	Add-ons <ahref="http://blog.bonardo.net/2013/01/29/add-ons-devs-heads-up-history-api-removals-in-places">History API removals</a> in Places	\N	\N	21	\N	2	\N	\N	\N
309	\N	XBL Scopes Enabled (<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=834697">bugs 834697</a>)	\N	\N	21	\N	2	\N	\N	\N
310	\N	Implemented <a href="http://anton.kovalyov.net/2013/02/22/remote-profiling/">Remote Profiling</a>	\N	\N	21	\N	5	\N	1000	\N
311	793972	Details button on Crash Reporter	\N	\N	20	\N	4	1	\N	\N
312	808408	hide virtual keyboard when bookmarks list is opened	\N	\N	20	2	4	2	\N	\N
313	829284	Unity plugin doesn't display in HiDPI mode	\N	\N	20	\N	4	1	\N	\N
314	\N	The 'Quit' menu item has been removed from Firefox versions running on ICS and higher to follow Android convention. When done browsing just tap Home or Back. Use the <a href="https://addons.mozilla.org/en-US/android/addon/quitnow/">QuitNow</a> add-on if you want more control	\N	\N	20	2	2	2	1500	\N
315	817828	Black area near tabs button after the URL bar is animated	20	\N	20	\N	4	2	\N	\N
316	\N	CSS -moz-user-select:none selection changed to improve compatibility with -webkit-user-select:none (<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=816298">bug 816298</a>)	\N	\N	21	\N	2	\N	\N	\N
317	829454	'Video can't be played because the file is corrupt' on some HTC Gingerbread (Android 2.3) devices	20	\N	\N	\N	\N	2	\N	\N
318	\N	StageFright blocklisted for some graphics drivers, see <a href="https://wiki.mozilla.org/Blocklisting/Blocked_Graphics_Drivers#On_Android_2"> list</a> and block will be removed for many Android versions in <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=823253">bug 823253</a>	17	\N	\N	\N	\N	2	\N	\N
319	847627	Browsing and Download history clearing needs unification to avoid confusion on clearing download history	20	\N	21	1	\N	1	\N	\N
320	853463	Download statusbar add-on continues downloading files from Normal Browsing, when switching to Private Browsing	\N	\N	\N	\N	\N	1	\N	\N
321	844676	 gUM <video> surface not available immediately in dual-GPU MacBooks	\N	\N	\N	\N	\N	1	\N	\N
322	833351	Private Browsing - can't see URL bar text on variant of HTC Sense UI (Froyo)	20	\N	\N	\N	\N	2	\N	\N
323	840593	In content UI cut off on small screens	\N	\N	21	1	\N	2	\N	\N
325	\N	Ability to save media files on long tap	\N	\N	21	\N	1	2	900	\N
785342	\N	Windows: Firefox now follows display scaling options to render text larger on high-res displays	\N	\N	22	\N	1	1	\N	\N
785343	\N	Mac OS X: Download progress in Dock application icon	\N	\N	22	\N	1	1	\N	\N
785344	\N	Ability to only allow cookies <a href="https://blog.mozilla.org/privacy/2013/02/25/firefox-getting-smarter-about-third-party-cookies/">from sites you've visited</a>	\N	\N	999	\N	1	1	\N	\N
785345	\N	HTML5 audio/video playback rate can now be changed	\N	\N	22	\N	1	1	\N	\N
785346	\N	Pointer Lock API can now be used outside of fullscreen	\N	\N	22	\N	2	1	\N	\N
785347	\N	New built-in font inspector	\N	\N	22	\N	5	1	\N	\N
785348	\N	Added clipboardData API for JavaScript access to a user's clipboard	\N	\N	22	\N	5	1	\N	\N
785349	\N	Navigation Bar now hides when scrolling through a website	\N	\N	999	\N	1	2	\N	\N
785350	\N	Smaller tablets will now get the full tablet UI	\N	\N	22	\N	1	2	\N	\N
785351	\N	New HTML5 <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=839371">&lt;data&gt;</a> and <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=629801">&lt;time&gt;</a> elements	\N	\N	22	\N	3	\N	\N	\N
785353	\N	New Web Notifications API implemented	\N	\N	22	\N	5	\N	\N	\N
785354	\N	Improved memory usage and display time <a href="https://bugzilla.mozilla.org/buglist.cgi?quicksearch=716140%2C689623%2C661304">when rendering images</a>	\N	\N	22	\N	2	1	\N	\N
785355	\N	Improved WebGL rendering performance through <a href="https://bugzilla.mozilla.org/buglist.cgi?quicksearch=829747">asynchronous canvas updates</a>	\N	\N	22	\N	2	\N	\N	\N
785356	\N	Plain text files displayed within Firefox will now word-wrap	\N	\N	22	\N	2	\N	\N	\N
785357	829952	Scrolling using some high-resolution-scroll aware touchpads feels slow	\N	\N	22	\N	\N	1	\N	\N
785358	\N	20.0.1 - Windows-only update to handle issues around handling UNC paths (see <a href="http://bugzil.la/846848">bug 846848</a>)	20	3	20	\N	4	1	1000	1
785359	\N	20.0.1 update to fix ANR hangs and DB-lock related crashes on older devices	20	3	20	3	4	2	1000	1
785360	\N	Mixed content blocking enabled to protects our users from man-in-the-middle attacks and eavesdroppers on HTTPS pages (<a href="https://blog.mozilla.org/security/2013/05/16/mixed-content-blocking-in-firefox-aurora/">learn more</a>)	23	1	23	\N	1	1	1000	\N
785361	\N	Support for new scrollbar style in Mac OSX 10.7 and newer	\N	\N	23	1	1	1	\N	\N
785362	\N	Support bounce behavior when reaching top and bottom of documents on Mac OSX 10.7 and newer	\N	\N	23	1	1	1	\N	\N
785363	\N	Added animations for swipe navigation in Mac OSX 10.7 and newer	\N	\N	23	1	1	1	\N	\N
785364	\N	Implemented a global browser console	\N	\N	23	1	5	1	\N	\N
785365	\N	Write more accessible pages on touch interfaces with new ARIA role for key buttons	\N	\N	23	1	5	\N	\N	\N
785366	\N	Dropped blink effect from text-decoration: blink; and completely removed &lt;blink&gt; element 	\N	\N	23	1	5	\N	1000	\N
785367	\N	Consolidated search default preference now lets users switch to another search provider in the search box and change the setting for addressbar and context search	\N	\N	23	1	2	1	1000	\N
785368	\N	Support a full share panel (Social API)	\N	\N	23	1	5	1	\N	\N
785370	\N	"Load images automatically", "Enable JavaScript", and Always show the tab bar" checkboxes removed from preferences	\N	\N	23	1	2	1	\N	\N
785372	\N	Implemented switch-to-tab	\N	\N	23	1	1	2	\N	\N
785373	\N	Specify a default search engine	\N	\N	23	1	1	2	\N	\N
785374	\N	Added a setting to let users display URLs in the title bar instead of page titles. Read more in the <a href="https://blog.mozilla.org/ux/2013/05/polish-all-the-things1/">ux blogpost</a>.	\N	\N	23	1	1	2	900	\N
785375	\N	Long press Reader Mode icon to add article to Reading List (try it!)	\N	\N	23	1	1	2	1000	\N
785376	\N	Added Serif/Sans Serif font toggle to Reader Mode	\N	\N	23	1	1	2	\N	\N
785377	\N	asm.js optimizations (<a href="https://blog.mozilla.org/luke/2013/03/21/asm-js-in-firefox-nightly/">OdinMonkey</a>) enabled for major performance improvements	\N	\N	22	\N	1	1	\N	\N
785378	\N	For user security, the |Components| object is no longer accessible from web content	\N	\N	22	\N	2	1	\N	\N
785379	\N	Social services management implemented in Add-ons Manager	\N	\N	22	\N	1	1	\N	\N
785381	\N	WebRTC is now <a href="http://blog.mozilla.org/futurereleases/2013/05/16/firefox-beta-now-includes-webrtc-on-by-default">enabled by default</a>!	\N	\N	22	\N	2	1	\N	\N
785382	\N	Improved about:memory's functional UI	\N	\N	23	1	2	1	\N	\N
785383	\N	Enabled DXVA2 on Windows Vista+ to accelerate H.264 video decoding	\N	\N	23	1	2	1	\N	\N
785384	\N	Replaced plugin installation notification bar with door hanger	\N	\N	23	1	2	1	\N	\N
785388	\N	Partial support for Web Audio, targeted at web developers for testing	23	1	23	1	5	\N	1000	\N
785389	\N	Dynamic toolbar hides navigation bar when scrolling down page content	22	\N	23	\N	1	2	500	\N
785390	\N	HTML5 &lt;input type="range"&gt; form control implemented 	\N	\N	23	\N	5	\N	\N	\N
785391	\N	Basic support for subscribing to feeds (RSS/Atom) with long-tap in address bar	\N	\N	23	1	1	2	500	\N
785392	\N	Added unprefixed requestAnimationFrame	\N	\N	23	1	5	\N	\N	\N
\.


--
-- TOC entry 2222 (class 0 OID 24606)
-- Dependencies: 169
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Products" (id, product_name, product_text) FROM stdin;
1	Firefox	<p>Check out "What&#146;s New" and "Known Issues" for this version of Firefox below. As always, you&#146;re encouraged to <a href="http://input.mozilla.com/feedback">tell us what you think</a>, or <a href="https://bugzilla.mozilla.org/">file a bug in Bugzilla</a>.</p>
2	Firefox for mobile	<p>Check out "What&#146;s New" and "Known Issues" for this version of Firefox for mobile below. As always, you&#146;re encouraged to <a href="http://input.mozilla.com/feedback">tell us what you think</a>, or <a href="https://bugzilla.mozilla.org/">file a bug in Bugzilla</a>.</p>
3	Firefox ESR	<p>Check out "What&#146;s New" for this version of Firefox ESR below. As always, you&#146;re encouraged to <a href="http://input.mozilla.com/feedback">tell us what you think</a>, or <a href="https://bugzilla.mozilla.org/">file a bug in Bugzilla</a>.</p> 
\.


--
-- TOC entry 2223 (class 0 OID 24616)
-- Dependencies: 170
-- Data for Name: Releases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Releases" (id, product, channel, version, sub_version, release_date, release_text) FROM stdin;
1	1	1	10	0	2011-11-11 00:00:00	\N
2	2	1	10	0	2011-11-11 00:00:00	\N
3	1	1	11	0	2011-12-22 00:00:00	\N
4	2	1	11	0	2011-12-22 00:00:00	\N
5	1	2	10	0	2011-12-21 00:00:00	\N
6	2	2	10	0	2011-12-21 00:00:00	\N
14	1	3	10	0	2012-01-31 00:00:00	\N
15	2	3	10	0	2012-01-31 00:00:00	\N
16	1	1	12	0	2012-02-03 00:00:00	\N
17	2	1	12	0	2012-02-03 00:00:00	\N
18	1	2	11	0	2012-02-03 00:00:00	\N
19	2	2	11	0	2012-02-03 00:00:00	\N
20	1	3	10	1	2012-02-10 00:00:00	\N
21	2	3	10	1	2012-02-10 00:00:00	\N
22	1	3	10	2	2012-02-16 00:00:00	\N
23	2	3	10	2	2012-02-16 00:00:00	\N
24	3	5	10	3	2012-03-13 00:00:00	\N
25	1	3	11	0	2012-03-13 00:00:00	\N
26	2	3	10	3	2012-03-13 00:00:00	\N
27	1	1	13	0	2012-03-19 00:00:00	\N
28	2	1	13	0	2012-03-19 00:00:00	\N
29	1	2	12	0	2012-03-16 00:00:00	\N
30	2	2	12	0	2012-03-16 00:00:00	\N
31	1	3	12	0	2012-04-24 00:00:00	\N
32	2	3	10	4	2012-04-24 00:00:00	\N
33	3	5	10	4	2012-04-24 00:00:00	\N
34	1	2	13	0	2012-04-26 00:00:00	\N
35	2	2	13	0	2012-04-27 00:00:00	\N
36	1	1	14	0	2012-04-27 00:00:00	\N
37	2	1	14	0	2012-04-30 00:00:00	\N
38	2	2	14	0	2012-05-15 00:00:00	\N
39	1	2	14	0	2012-05-15 00:00:00	\N
40	1	3	13	0	2012-06-05 00:00:00	\N
41	3	5	10	5	2012-06-05 00:00:00	\N
42	2	3	10	5	2012-06-05 00:00:00	\N
43	1	2	14	0	2012-06-07 00:00:00	\N
44	1	1	15	0	2012-06-07 00:00:00	\N
45	2	1	15	0	2012-06-07 00:00:00	\N
46	1	3	13	1	2012-06-15 00:00:00	\N
47	2	3	14	0	2012-06-26 00:00:00	\N
48	1	3	14	0	2012-06-26 00:00:00	\N
49	1	3	14	1	2012-07-17 00:00:00	\N
50	2	3	14	1	2012-07-17 00:00:00	\N
51	1	2	15	0	2012-07-19 00:00:00	\N
52	2	2	15	0	2012-07-19 00:00:00	\N
53	1	1	16	0	2012-07-20 00:00:00	\N
54	2	1	16	0	2012-07-20 00:00:00	\N
55	2	3	14	2	2012-08-07 00:00:00	\N
56	1	3	15	0	2012-08-28 00:00:00	\N
57	2	3	15	0	2012-08-28 00:00:00	\N
58	3	5	10	7	2012-08-28 00:00:00	\N
59	1	2	16	0	2012-08-30 00:00:00	\N
60	2	2	16	0	2012-08-30 00:00:00	\N
61	1	1	17	0	2012-08-31 00:00:00	\N
62	2	1	17	0	2012-08-31 00:00:00	\N
63	1	3	15	1	2012-09-06 00:00:00	\N
64	2	3	15	1	2012-09-10 00:00:00	\N
65	1	3	16	0	2012-10-09 00:00:00	\N
66	2	3	16	0	2012-10-09 00:00:00	\N
67	3	5	10	8	2012-10-08 00:00:00	\N
68	1	1	18	0	2012-10-12 00:00:00	\N
69	2	1	18	0	2012-10-12 00:00:00	\N
70	1	2	17	0	2012-10-11 00:00:00	\N
71	2	2	17	0	2012-10-11 00:00:00	\N
72	1	3	16	1	2012-10-11 00:00:00	\N
73	2	3	16	1	2012-10-11 00:00:00	\N
74	1	3	16	2	2012-10-26 00:00:00	\N
75	2	3	16	2	2012-10-26 00:00:00	\N
76	1	3	17	0	2012-11-20 00:00:00	\N
77	2	3	17	0	2012-11-19 00:00:00	\N
78	1	2	18	0	2012-11-26 00:00:00	\N
79	2	2	18	0	2012-11-26 00:00:00	\N
80	1	5	10	11	2012-11-20 00:00:00	\N
81	1	1	19	0	2012-11-26 00:00:00	\N
82	2	1	19	0	2012-11-26 00:00:00	\N
83	1	3	17	1	2012-11-30 00:00:00	\N
84	1	5	17	1	2012-11-30 00:00:00	\N
85	1	3	18	0	2013-01-08 00:00:00	\N
86	2	3	18	0	2013-01-08 00:00:00	\N
87	1	2	19	0	2013-01-10 00:00:00	\N
88	2	2	19	0	2013-01-10 00:00:00	\N
89	1	1	20	0	2013-01-11 00:00:00	\N
90	2	1	20	0	2013-01-11 00:00:00	\N
91	1	3	19	0	2013-02-19 00:00:00	\N
92	2	3	19	0	2013-02-19 00:00:00	\N
93	1	1	21	0	2013-02-22 00:00:00	\N
94	2	1	21	0	2013-02-22 00:00:00	\N
95	1	2	20	0	2013-02-22 00:00:00	\N
96	2	2	20	0	2013-02-25 00:00:00	\N
97	1	3	20	0	2013-04-02 00:00:00	\N
98	2	3	20	0	2013-04-02 00:00:00	\N
99	1	2	21	0	2013-04-04 00:00:00	\N
100	2	2	21	0	2013-04-04 00:00:00	\N
101	1	1	22	0	2013-04-05 00:00:00	\N
102	2	1	22	0	2013-04-05 00:00:00	\N
103	1	3	20	1	2013-04-11 00:00:00	\N
104	2	3	20	1	2013-04-11 00:00:00	\N
105	1	3	21	0	2013-05-14 00:00:00	\N
106	2	3	21	0	2013-05-14 00:00:00	\N
108	1	1	23	0	2013-05-17 00:00:00	\N
109	2	1	23	0	2013-05-17 00:00:00	\N
110	1	2	22	0	2013-05-16 00:00:00	\N
111	2	2	22	0	2013-05-16 00:00:00	\N
\.


--
-- TOC entry 2224 (class 0 OID 24635)
-- Dependencies: 171
-- Data for Name: Tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Tags" (id, tag_text, sort_num) FROM stdin;
1	NEW	1
2	CHANGED	2
3	HTML5	4
4	FIXED	5
5	DEVELOPER	3
\.


--
-- TOC entry 2203 (class 2606 OID 24596)
-- Name: Channels_channel_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Channels"
    ADD CONSTRAINT "Channels_channel_name_key" UNIQUE (channel_name);


--
-- TOC entry 2205 (class 2606 OID 24594)
-- Name: Channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Channels"
    ADD CONSTRAINT "Channels_pkey" PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 25342)
-- Name: Notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Notes"
    ADD CONSTRAINT "Notes_pkey" PRIMARY KEY (id);


--
-- TOC entry 2207 (class 2606 OID 24613)
-- Name: Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY (id);


--
-- TOC entry 2209 (class 2606 OID 24615)
-- Name: Products_product_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Products"
    ADD CONSTRAINT "Products_product_name_key" UNIQUE (product_name);


--
-- TOC entry 2211 (class 2606 OID 24624)
-- Name: Releases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Releases"
    ADD CONSTRAINT "Releases_pkey" PRIMARY KEY (id);


--
-- TOC entry 2213 (class 2606 OID 24642)
-- Name: Tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Tags"
    ADD CONSTRAINT "Tags_pkey" PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 25343)
-- Name: Notes_first_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Notes"
    ADD CONSTRAINT "Notes_first_channel_fkey" FOREIGN KEY (first_channel) REFERENCES "Channels"(id);


--
-- TOC entry 2219 (class 2606 OID 25348)
-- Name: Notes_fixed_in_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Notes"
    ADD CONSTRAINT "Notes_fixed_in_channel_fkey" FOREIGN KEY (fixed_in_channel) REFERENCES "Channels"(id);


--
-- TOC entry 2220 (class 2606 OID 25353)
-- Name: Notes_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Notes"
    ADD CONSTRAINT "Notes_product_fkey" FOREIGN KEY (product) REFERENCES "Products"(id);


--
-- TOC entry 2217 (class 2606 OID 24630)
-- Name: Releases_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Releases"
    ADD CONSTRAINT "Releases_channel_fkey" FOREIGN KEY (channel) REFERENCES "Channels"(id);


--
-- TOC entry 2216 (class 2606 OID 24625)
-- Name: Releases_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Releases"
    ADD CONSTRAINT "Releases_product_fkey" FOREIGN KEY (product) REFERENCES "Products"(id);


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-05-23 15:13:49 PDT

--
-- PostgreSQL database dump complete
--

