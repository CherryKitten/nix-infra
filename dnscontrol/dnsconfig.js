var REG_NAMECHEAP = NewRegistrar("namecheap");
var DSP_NAMECHEAP = NewDnsProvider("namecheap");

var FASTMAIL_RECORDS = function(domain) {
    return [
        MX("@", 10, "in1-smtp.messagingengine.com."),
        MX("@", 20, "in2-smtp.messagingengine.com."),
        TXT("@", "v=spf1 include:spf.messagingengine.com ?all"),
        CNAME("fm1._domainkey", "fm1." + domain + ".dkim.fmhosted.com."),
        CNAME("fm2._domainkey", "fm2." + domain + ".dkim.fmhosted.com."),
        CNAME("fm3._domainkey", "fm3." + domain + ".dkim.fmhosted.com."),
    ]
}

var OCELOT_v4 = "128.140.109.125"
var OCELOT_v6 = "2a01:4f8:c2c:bd32::1"
var SERVAL_v4 = "116.203.116.228"
var SERVAL_v6 = "2a01:4f8:1c1b:5db9::1"
var MUNCHKIN_v4 = "5.75.143.135"
var MUNCHKIN_v6 = "2a01:4f8:1c1b:4c9f::1"

D("cherrykitten.xyz", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    A("ocelot", OCELOT_v4),
    AAAA("ocelot", OCELOT_v6),
    A("serval", SERVAL_v4),
    AAAA("serval", SERVAL_v6),
    A("munchkin", MUNCHKIN_v4),
    AAAA("munchkin", MUNCHKIN_v6),
);

D("cherrykitten.dev", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    ALIAS("@", "ocelot.cherrykitten.xyz."),
    CNAME("git", "ocelot.cherrykitten.xyz."),
    CNAME("rss", "ocelot.cherrykitten.xyz."),
    CNAME("graph", "serval.cherrykitten.xyz."),
    URL301("blog", "https://cherrykitten.dev/blog/"),
    FASTMAIL_RECORDS("cherrykitten.dev"),
);

D("catgirls.love", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    IGNORE("*", "A", "*"),
    FASTMAIL_RECORDS("catgirls.love"),
);

D("cherrykitten.gay", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    ALIAS("@", "ocelot.cherrykitten.xyz."),
    CNAME("matrix", "ocelot.cherrykitten.xyz."),
);

D("sammy.moe", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    FASTMAIL_RECORDS("sammy.moe"),
);

D("thebleakest.link", REG_NAMECHEAP, DnsProvider(DSP_NAMECHEAP),
    ALIAS("@", "munchkin.cherrykitten.xyz."),
);
