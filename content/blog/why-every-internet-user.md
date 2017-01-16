Title: Why every internet user should care about FISCR 16-01
Date: 2016-12-29 00:00:00 GMT
Slug: why-every-internet-user
Authors: Steven Presser
Category: Articles
Summary: Recently, I introduced FISCR 16-01, including the effects of the decision and how the court got it massively wrong. What I didn't cover was the broader applicability of the decision and why everyone should care. So lets do that now.

Recently, I introduced FISCR 16-01, including the effects of the decision and how the court got it massively wrong. What I didn't cover was the broader applicability of the decision and why everyone should care. So lets do that now.

##FISCR 16-01 Applies to the Internet

Pen Registers, the legal tool at issue in this case, are all about so-called DRAS (dialing, routing, addressing and signaling) information - more commonly known as telephone metadata. In telephony, this is generally agreed to be the digits a user dials &ndash; when they're dialed in order to connect one telephone to another.

Enter the internet.

The internet is a wealth of routing and signaling information. The model usually used to represent this is the [TCP/IP model](https://tools.ietf.org/html/rfc1122). Unfortunately, it's a technical model and covers way too much detail for what we need here, so we'll be using a simplified version.

In order to understand just how much information there is in internet metadata, let's take a look at how much we can pull out of a typical web request &ndash; one page, not including any images, scripts or other dynamic content.

A typical request might look like:

    Source IP: 10.0.0.165
    Source Port: 53051
    Destination IP: 63.241.40.35
    Destination Port: 80
    GET /sites/default/files/FISCR%20Opinion%2016-01%20Redacted.pdf HTTP/1.1
    Host: www.fisc.uscourts.gov
    Connection: keep-alive User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36
    Accept: */*
    Referer: http://www.fisc.uscourts.gov/docket/16-01
    Accept-Encoding: gzip, deflate, sdch
    Accept-Language: en-US,en;q=0.8
    Cookie: has_js=1; _ga=GA1.2.846628581.1478872336

Let's see what information we can pull out. First, the source IP is is a mostly[^1] unique identifier. By knowing when data was captured, an agent could go to an ISP and request information about the identity of the subscriber. Next, the line that begins in GET. This is called the HTTP request line, and is used to tell the server what content exactly is being requested. It pretty clearly counts as routing data. In this case, it's a request for the FISCR 16-01 decision.

The remaining lines are HTTP headers. The Host header is the most noticeable of these. Sometimes multiple websites are served from the same server. The host header is used to disambiguate which website the request is for. The host header plus the request line forms the full URL (Uniform Resource Locater &ndash; a unique address for a document, photo, script, etc online).

Looking further down, there is the referer[^2] header. This contains the address of the page the user came from. In this case, it shows that I came from the page listing all of the FISCR 16-01 documents. This, along with a record of other pages viewed, can be used to reconstruct a browsing session, including the links a user clicks.

Finally, the cookie header. Cookies are small bits of data that websites store on a user's computer in order to be able to identify them for later requests[^3]. Modern security paradigms state that it's critical that a cookie not contain any actual information, merely a randomized unique identifier that the server can use to find the relevant information. However, this also means that cookies, if intercepted, can be used to uniquely identify a browser or a user. If a website maintains record of them long enough, the government could even use the cookie data to request the real-world identity of a user.

So from a single request, we have learned:

- What website a user is on

- What page a user is viewing

- What their last-viewed page was

- A unique identifier for the user that is maintained for the entire session (or longer)

It's a huge privacy violation, letting a pen register essentially be used to watch what one does online.

But wait, it gets worse. Sometimes the HTTP request line contains data the user input on the website. For example, a Google search for "FISCR"[^4] would have an HTTP request line that reads:

    GET /?q=FISCR HTTP/1.1

So not only can metadata be used to determine what pages you're viewing, it can show what you're searching for and almost any other input you give any web page.

To make this even more terrible? I've been using only the public and generally-accepted limits on what is metadata. Given how we've seen the intelligence community [twist the definition of collect (C2.2.1, page 15)](https://fas.org/irp/doddir/dod/d5240_1_r.pdf) and given FISCR 16-01's broadening of the collection of content in order to get at metadata, it may be permissible to collect the bodies of webpages as part of a pen register. After all, they do often contain links, which are addressing information.

In summary, FISCR 16-01 is terrifying in the amount of information it allows the government to collect with a effectively-nonexistent level of judicial oversight.

##FISCR 16-01 Applies within the United States

"But wait," you say, "I thought FISA stood for _Foreign_ Intelligence Surveillance Act. How could it possibly apply within the US?"

You're right &ndash; FISA (the law) is only supposed to deal with _foreign_ intelligence matters. FISCR 16-01 technically is a foreign intelligence matter &ndash; it related to an unknown US person who may be spying for a foreign power. However, FISC is a federal circuit court, albeit one without a specific geographical region. This gives it the power to hear certain federal cases &ndash; those which cross district lines. Telecommunications almost always cross district lines, meaning that FISC can hear these cases.

To make things more complicated, there are actually two pen register laws &ndash; one as part of FISA ([50 U.S.C . Ch. 36](https://www.law.cornell.edu/uscode/text/50/chapter-36)), and one for use domestically ([18 U.S.C. Ch. 206](https://www.law.cornell.edu/uscode/text/18/part-II/chapter-206)). The two are "cross-referenced", meaning that the text of one may be used to help interpret the other, case law surrounding one can be used to help interpret the other, and decisions applying to one often automatically apply to the other. This allows the court to use definitions from the domestic wiretapping statute in the FISA courts &ndash; as happened here. FISC used definitions from the domestic wiretapping statute to interpret the FISA pen register statute.

More frighteningly, this means that findings from FISCR 16-01 can immediately be used on domestic pen registers, as issued to, for example, the FBI or DEA. Federal agents can now apply for pen registers and use those to record the contents of calls. Remember, courts cannot deny pen register applications.

Neither law allows the use of any captured call content to be used in court. However, there's a massive difference between "not usable in court" and "not to be captured". We've seen how captured information can be abused to [create investigations that never happened](http://www.reuters.com/article/us-dea-sod-idUSBRE97409R20130805). And we've seen that the real source of these investigations is information that could not be used in court.

There is also a more worrying consequence to FISCR 16-01 applying within the US: The "chilling effect". The chilling effect is a theory whereby people, knowing that the government might be listening, may chose not to express controversial or anti-government views. In short, the chilling effect theory states that the more government intrusion we allow into the lives of citizens, the less freedom, especially of speech, they feel they have. Citizens may fear expressing views that anger the government because the government may start an investigation into them &ndash; simply as harassment or payback for expressing a view. This obviously would be extremely difficult to prove in court, making it almost impossible for citizens to fight.

Thus, FISCR 16-01 has a chilling effect. It effectively allows government agents to listen to any communication by anyone. If someone says something the agents don't like, they may start a potentially extremely disruptive and expensive investigation &ndash; even if they know they won't find anything.

This sort of harassing investigation is fundamentally unamerican. In fact, it is one of the causes of our own revolution. Leading up to the American Revolution, the British government would often punish dissent by searching the homes and businesses of those who expressed it. The searches weren't intended to find anything, but instead as a massive inconvenience and an extra-legal punishment.

The Fourth Amendment is very deliberately written to prevent this sort of investigation and harassment. It does not deal with the legality of using evidence in prosecution, but instead with the legality and processes surrounding even performing the investigation.

FISCR 16-01 effectively destroys the Fourth Amendment right to freedom from search and seizure and does significant damage to the First Amendment right to free speech.

##Conclusion

We've seen that FISCR 16-01 applies to all telecommunications and to all people, including citizens of the US. We've seen how it can be used to penetrate into our daily lives &ndash; from web browsing to telephone calls. We've seen how it applies within the US. Finally, we've seen how FISCR 16-01 could be used to suppress free speech and quash dissent within the US. FISCR 16-01 is fundamentally opposite our basic American and humman rights and fundamentally opposed to our values.

###

[^1]:On the larger internet, IP addresses are unique. However, some subsets of addresses are set aside for use in home and business networks. There are special protocols and technology in place to translate from these special subsets to the larger internet.

[^2]:No, this is not misspelled here. The HTTP specification misspelled referrer. While it could be corrected, the old spelling need to be usable for backwards-compatibility, making it just generally more of a pain than it's worth.

[^3]:HTTP is a "stateless protocol", meaning that each request is handled independently and with no relation to any other. Cookies let websites give the appearance of having sessions by allowing them to associate state (usually stored in a database) with a particular cookie identifier and therefore appear to have sessions when the user requests additional webpages.

[^4]:Google encrypts all searches, so a simple pen register wouldn't see this data. However, Google searches are important enough that the intelligence agencies probably have something set up so that they can read them regardless. This would require Google's (legally compelled) cooperation.

