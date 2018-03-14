
def makeHtmlTag(tag, *args, **kwds):
    def real_decorator(fn):
        css_class = " {0}".format(kwds["css_class"]) \
                                     if "css_class" in kwds else ""
        def wrapped(*args, **kwds):
            return "<"+tag+css_class+">" + fn(*args, **kwds) + "</"+tag+">"
        return wrapped
    return real_decorator

@makeHtmlTag(tag="td", css_class="green_css")
@makeHtmlTag(tag="span", css_class="italic_css")
def port(interface):
    return interface

@makeHtmlTag(tag="td", css_class="style='background-color:gray'")
@makeHtmlTag(tag="span", css_class="italic_css")
def delimter(interface):
    return interface

@makeHtmlTag(tag="tr")
def maketr(content):
    return content

@makeHtmlTag(tag="table border=1")
@makeHtmlTag(tag="tboay")
def maketable(rows):
    return rows

def gtable():
    maketb=""
    maketb+=maketr("beul9007")
    inter="s"
    for r in range(1,5):
        row=""
        if r == 4:
            inter="ob-"
            for i in range(1,5):
                row+=port("{0}{1}-{2}".format(inter,r,i))
            row+=delimter("x")
            row+=port("ILO")

        else:

            for i in range(1,5):
                row+=port("{0}{1}-{2}".format(inter,r,i))
            row+=delimter("x")
            for i in range(1,5):
                row+=port("{0}{1}-{2}".format(inter,r+3,i))
        maketb+=maketr(row)


    return maketable(maketb)

print gtable()

