# Langs (Safe Embedded Languages)

# `lang` defines custom text types with automatic escaping.
lang HTML:

    # Custom escaping rules can be created with `convert`
    convert(t:Text -> HTML):
        t = t:replace_all({$/&/="&amp;", $/</="&lt;", $/>/="&gt;"})
        return HTML.from_text(t)

    func paragraph(content:HTML -> HTML):
        return $HTML"<p>$content</p>"


# Type safety prevents injection:
func greet(name:HTML -> HTML):
    return $HTML"Hello, $name!"

func main():

    malicious_input := "<b>hello</b>"

    safe := $HTML"User said: $malicious_input"

    >> safe
    = ???

    >> safe:paragraph()
    = ???

    greeting := greet(malicious_input)  # This should fail
