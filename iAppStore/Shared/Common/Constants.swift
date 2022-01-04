//
//  Constants.swift
//  iAppStore
//
//  Created by HTC on 2021/12/20.
//  Copyright © 2021 37 Mobile Games. All rights reserved.

import Foundation


struct TSMGConstants {
    
    static var rankingTypeLists: [String] = [
        "热门免费榜",
        "热门付费榜",
        "畅销榜",
        "新上架榜",
        "新上架的免费榜",
        "新上架的付费榜",
        "热门免费 iPad 榜",
        "热门付费 iPad 榜",
        "畅销的 iPad 榜",
    ]
    
    static var rankingTypeListIds: [String: String] = [
        "热门免费榜" : "topFreeApplications",
        "热门付费榜" : "topPaidApplications",
        "畅销榜" : "topGrossingApplications",
        "新上架榜" : "newApplications",
        "新上架的免费榜" : "newFreeApplications",
        "新上架的付费榜" : "newPaidApplications",
        "热门免费 iPad 榜" : "topFreeiPadApplications",
        "热门付费 iPad 榜" : "topPaidiPadApplications",
        "畅销的 iPad 榜" : "topGrossingiPadApplications",
    ]
    
    static var categoryTypeLists: [String] = [
        "所有 App",
        "游戏",
        "社交",
        "效率",
        "图书",
        "商务",
        "娱乐",
        "音乐",
        "教育",
        "财务",
        "天气",
        "工具",
        "旅游",
        "体育",
        "购物",
        "生活",
        "医疗",
        "导航",
        "新闻",
        "美食佳饮",
        "健康健美",
        "报刊杂志",
        "参考资料",
        "摄影与录像",
        "图形和设计",
        "软件开发工具",
    ]
    
    static var categoryTypeListIds: [String: String] = [
        "所有 App" : "0",
        "游戏" : "6014",
        "社交" : "6005",
        "效率" : "6007",
        "工具" : "6002",
        "娱乐" : "6016",
        "购物" : "6024",
        "音乐" : "6011",
        "新闻" : "6009",
        "图书" : "6018",
        "教育" : "6017",
        "财务" : "6015",
        "天气" : "6001",
        "旅游" : "6003",
        "体育" : "6004",
        "生活" : "6012",
        "医疗" : "6020",
        "导航" : "6010",
        "商务" : "6000",
        "美食佳饮" : "6023",
        "健康健美" : "6013",
        "报刊杂志" : "6021",
        "参考资料" : "6006",
        "摄影与录像" : "6008",
        "图形和设计" : "6027",
        "软件开发工具" : "6026",
    ]
    
    
    static var regionTypeLists: [String] = [
        "中国",
        "中国香港",
        "中国台湾",
        "中国澳门",
        "美国",
        "日本",
        "韩国",
        "英国",
        "法国",
        "德国",
        "泰国",
        "俄罗斯",
        "新加坡",
        "阿富汗",
        "阿尔巴尼亚",
        "阿尔及利亚",
        "安哥拉",
        "安圭拉",
        "安提瓜和巴布达",
        "阿根廷",
        "亚美尼亚",
        "澳大利亚",
        "奥地利",
        "阿塞拜疆",
        "巴哈马",
        "巴林",
        "巴巴多斯",
        "白俄罗斯",
        "比利时",
        "伯利兹",
        "贝宁",
        "百慕大",
        "不丹",
        "玻利维亚",
        "波斯尼亚和黑塞哥维那",
        "博茨瓦纳",
        "巴西",
        "英属维尔京群岛",
        "文莱达鲁萨兰国",
        "保加利亚",
        "布基纳法索",
        "柬埔寨",
        "喀麦隆",
        "加拿大",
        "佛得角",
        "开曼群岛",
        "乍得",
        "智利",
        "哥伦比亚",
        "哥斯达黎加",
        "克罗地亚",
        "塞浦路斯",
        "捷克共和国",
        "科特迪瓦",
        "刚果民主共和国",
        "丹麦",
        "多米尼加",
        "多明尼加共和国",
        "厄瓜多尔",
        "埃及",
        "萨尔瓦多",
        "爱沙尼亚",
        "埃斯瓦蒂尼",
        "斐济",
        "芬兰",
        "加蓬",
        "冈比亚",
        "乔治亚州",
        "加纳",
        "希腊",
        "格林纳达",
        "危地马拉",
        "几内亚比绍",
        "圭亚那",
        "洪都拉斯",
        "匈牙利",
        "冰岛",
        "印度",
        "印度尼西亚",
        "伊拉克",
        "爱尔兰",
        "以色列",
        "意大利",
        "牙买加",
        "约旦",
        "哈萨克斯坦",
        "肯尼亚",
        "科索沃",
        "科威特",
        "吉尔吉斯斯坦",
        "老挝人民民主共和国",
        "拉脱维亚",
        "黎巴嫩",
        "利比里亚",
        "利比亚",
        "立陶宛",
        "卢森堡",
        "马达加斯加",
        "马拉维",
        "马来西亚",
        "马尔代夫",
        "马里",
        "马耳他",
        "毛里塔尼亚",
        "毛里求斯",
        "墨西哥",
        "密克罗尼西亚联邦",
        "摩尔多瓦",
        "蒙古",
        "黑山",
        "蒙特塞拉特",
        "摩洛哥",
        "莫桑比克",
        "缅甸",
        "纳米比亚",
        "瑙鲁",
        "尼泊尔",
        "荷兰",
        "新西兰",
        "尼加拉瓜",
        "尼日尔",
        "尼日利亚",
        "北马其顿",
        "挪威",
        "阿曼",
        "巴基斯坦",
        "帕劳",
        "巴拿马",
        "巴布亚新几内亚",
        "巴拉圭",
        "秘鲁",
        "菲律宾",
        "波兰",
        "葡萄牙",
        "卡塔尔",
        "刚果",
        "罗马尼亚",
        "卢旺达",
        "沙特阿拉伯",
        "塞内加尔",
        "塞尔维亚",
        "塞舌尔",
        "塞拉利昂",
        "斯洛伐克",
        "斯洛文尼亚",
        "所罗门群岛",
        "南非",
        "西班牙",
        "斯里兰卡",
        "圣基茨和尼维斯",
        "圣卢西亚",
        "圣文森特和格林纳丁斯",
        "苏里南",
        "瑞典",
        "瑞士",
        "圣多美和普林西比",
        "塔吉克斯坦",
        "坦桑尼亚",
        "汤加",
        "特立尼达和多巴哥",
        "突尼斯",
        "土耳其",
        "土库曼斯坦",
        "特克斯和凯科斯群岛",
        "阿联酋",
        "乌干达",
        "乌克兰",
        "乌拉圭",
        "乌兹别克斯坦",
        "瓦努阿图",
        "委内瑞拉",
        "越南",
        "也门",
        "赞比亚",
        "津巴布韦",
    ]
    
    static var regionTypeListIds: [String: String] = [
        "阿富汗" : "af",  // Afghanistan
        "阿尔巴尼亚" : "al",  // Albania
        "阿尔及利亚" : "dz",  // Algeria
        "安哥拉" : "ao",  // Angola
        "安圭拉" : "ai",  // Anguilla
        "安提瓜和巴布达" : "ag",  // Antigua and Barbuda
        "阿根廷" : "ar",  // Argentina
        "亚美尼亚" : "am",  // Armenia
        "澳大利亚" : "au",  // Australia
        "奥地利" : "at",  // Austria
        "阿塞拜疆" : "az",  // Azerbaijan
        "巴哈马" : "bs",  // Bahamas
        "巴林" : "bh",  // Bahrain
        "巴巴多斯" : "bb",  // Barbados
        "白俄罗斯" : "by",  // Belarus
        "比利时" : "be",  // Belgium
        "伯利兹" : "bz",  // Belize
        "贝宁" : "bj",  // Benin
        "百慕大" : "bm",  // Bermuda
        "不丹" : "bt",  // Bhutan
        "玻利维亚" : "bo",  // Bolivia
        "波斯尼亚和黑塞哥维那" : "ba",  // Bosnia and Herzegovina
        "博茨瓦纳" : "bw",  // Botswana
        "巴西" : "br",  // Brazil
        "英属维尔京群岛" : "vg",  // British Virgin Islands
        "文莱达鲁萨兰国" : "bn",  // Brunei Darussalam
        "保加利亚" : "bg",  // Bulgaria
        "布基纳法索" : "bf",  // Burkina Faso
        "柬埔寨" : "kh",  // Cambodia
        "喀麦隆" : "cm",  // Cameroon
        "加拿大" : "ca",  // Canada
        "佛得角" : "cv",  // Cape Verde
        "开曼群岛" : "ky",  // Cayman Islands
        "乍得" : "td",  // Chad
        "智利" : "cl",  // Chile
        "中国" : "cn",  // China mainland
        "哥伦比亚" : "co",  // Colombia
        "哥斯达黎加" : "cr",  // Costa Rica
        "克罗地亚" : "hr",  // Croatia
        "塞浦路斯" : "cy",  // Cyprus
        "捷克共和国" : "cz",  // Czech Republic
        "科特迪瓦" : "ci",  // Côte d'Ivoire
        "刚果民主共和国" : "cd",  // Democratic Republic of the Congo
        "丹麦" : "dk",  // Denmark
        "多米尼加" : "dm",  // Dominica
        "多明尼加共和国" : "do",  // Dominican Republic
        "厄瓜多尔" : "ec",  // Ecuador
        "埃及" : "eg",  // Egypt
        "萨尔瓦多" : "sv",  // El Salvador
        "爱沙尼亚" : "ee",  // Estonia
        "埃斯瓦蒂尼" : "sz",  // Eswatini
        "斐济" : "fj",  // Fiji
        "芬兰" : "fi",  // Finland
        "法国" : "fr",  // France
        "加蓬" : "ga",  // Gabon
        "冈比亚" : "gm",  // Gambia
        "乔治亚州" : "ge",  // Georgia
        "德国" : "de",  // Germany
        "加纳" : "gh",  // Ghana
        "希腊" : "gr",  // Greece
        "格林纳达" : "gd",  // Grenada
        "危地马拉" : "gt",  // Guatemala
        "几内亚比绍" : "gw",  // Guinea-Bissau
        "圭亚那" : "gy",  // Guyana
        "洪都拉斯" : "hn",  // Honduras
        "中国香港" : "hk",  // Hong Kong
        "匈牙利" : "hu",  // Hungary
        "冰岛" : "is",  // Iceland
        "印度" : "in",  // India
        "印度尼西亚" : "id",  // Indonesia
        "伊拉克" : "iq",  // Iraq
        "爱尔兰" : "ie",  // Ireland
        "以色列" : "il",  // Israel
        "意大利" : "it",  // Italy
        "牙买加" : "jm",  // Jamaica
        "日本" : "jp",  // Japan
        "约旦" : "jo",  // Jordan
        "哈萨克斯坦" : "kz",  // Kazakhstan
        "肯尼亚" : "ke",  // Kenya
        "韩国" : "kr",  // Korea, Republic of
        "科索沃" : "xk",  // Kosovo
        "科威特" : "kw",  // Kuwait
        "吉尔吉斯斯坦" : "kg",  // Kyrgyzstan
        "老挝人民民主共和国" : "la",  // Lao People's Democratic Republic
        "拉脱维亚" : "lv",  // Latvia
        "黎巴嫩" : "lb",  // Lebanon
        "利比里亚" : "lr",  // Liberia
        "利比亚" : "ly",  // Libya
        "立陶宛" : "lt",  // Lithuania
        "卢森堡" : "lu",  // Luxembourg
        "中国澳门" : "mo",  // Macao
        "马达加斯加" : "mg",  // Madagascar
        "马拉维" : "mw",  // Malawi
        "马来西亚" : "my",  // Malaysia
        "马尔代夫" : "mv",  // Maldives
        "马里" : "ml",  // Mali
        "马耳他" : "mt",  // Malta
        "毛里塔尼亚" : "mr",  // Mauritania
        "毛里求斯" : "mu",  // Mauritius
        "墨西哥" : "mx",  // Mexico
        "密克罗尼西亚联邦" : "fm",  // Micronesia, Federated States of
        "摩尔多瓦" : "md",  // Moldova
        "蒙古" : "mn",  // Mongolia
        "黑山" : "me",  // Montenegro
        "蒙特塞拉特" : "ms",  // Montserrat
        "摩洛哥" : "ma",  // Morocco
        "莫桑比克" : "mz",  // Mozambique
        "缅甸" : "mm",  // Myanmar
        "纳米比亚" : "na",  // Namibia
        "瑙鲁" : "nr",  // Nauru
        "尼泊尔" : "np",  // Nepal
        "荷兰" : "nl",  // Netherlands
        "新西兰" : "nz",  // New Zealand
        "尼加拉瓜" : "ni",  // Nicaragua
        "尼日尔" : "ne",  // Niger
        "尼日利亚" : "ng",  // Nigeria
        "北马其顿" : "mk",  // North&nbsp;Macedonia
        "挪威" : "no",  // Norway
        "阿曼" : "om",  // Oman
        "巴基斯坦" : "pk",  // Pakistan
        "帕劳" : "pw",  // Palau
        "巴拿马" : "pa",  // Panama
        "巴布亚新几内亚" : "pg",  // Papua New Guinea
        "巴拉圭" : "py",  // Paraguay
        "秘鲁" : "pe",  // Peru
        "菲律宾" : "ph",  // Philippines
        "波兰" : "pl",  // Poland
        "葡萄牙" : "pt",  // Portugal
        "卡塔尔" : "qa",  // Qatar
        "刚果" : "cg",  // Republic of the Congo
        "罗马尼亚" : "ro",  // Romania
        "俄罗斯" : "ru",  // Russia
        "卢旺达" : "rw",  // Rwanda
        "沙特阿拉伯" : "sa",  // Saudi Arabia
        "塞内加尔" : "sn",  // Senegal
        "塞尔维亚" : "rs",  // Serbia
        "塞舌尔" : "sc",  // Seychelles
        "塞拉利昂" : "sl",  // Sierra Leone
        "新加坡" : "sg",  // Singapore
        "斯洛伐克" : "sk",  // Slovakia
        "斯洛文尼亚" : "si",  // Slovenia
        "所罗门群岛" : "sb",  // Solomon Islands
        "南非" : "za",  // South Africa
        "西班牙" : "es",  // Spain
        "斯里兰卡" : "lk",  // Sri Lanka
        "圣基茨和尼维斯" : "kn",  // St. Kitts and Nevis
        "圣卢西亚" : "lc",  // St. Lucia
        "圣文森特和格林纳丁斯" : "vc",  // St. Vincent and The Grenadines
        "苏里南" : "sr",  // Suriname
        "瑞典" : "se",  // Sweden
        "瑞士" : "ch",  // Switzerland
        "圣多美和普林西比" : "st",  // São Tomé and Príncipe
        "中国台湾" : "tw",  // Taiwan
        "塔吉克斯坦" : "tj",  // Tajikistan
        "坦桑尼亚" : "tz",  // Tanzania
        "泰国" : "th",  // Thailand
        "汤加" : "to",  // Tonga
        "特立尼达和多巴哥" : "tt",  // Trinidad and Tobago
        "突尼斯" : "tn",  // Tunisia
        "土耳其" : "tr",  // Turkey
        "土库曼斯坦" : "tm",  // Turkmenistan
        "特克斯和凯科斯群岛" : "tc",  // Turks and Caicos
        "阿联酋" : "ae",  // UAE
        "乌干达" : "ug",  // Uganda
        "乌克兰" : "ua",  // Ukraine
        "英国" : "gb",  // United Kingdom
        "美国" : "us",  // United States
        "乌拉圭" : "uy",  // Uruguay
        "乌兹别克斯坦" : "uz",  // Uzbekistan
        "瓦努阿图" : "vu",  // Vanuatu
        "委内瑞拉" : "ve",  // Venezuela
        "越南" : "vn",  // Vietnam
        "也门" : "ye",  // Yemen
        "赞比亚" : "zm",  // Zambia
        "津巴布韦" : "zw", // Zimbabwe
    ]
}
