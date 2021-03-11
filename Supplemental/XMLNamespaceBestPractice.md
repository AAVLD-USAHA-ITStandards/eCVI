# XML Namespace 
## Best Practices

This standard uses the namespace to define the major version of the standard.  That is currently 2.  Thus, the namespace is defined by the URI 
`"http://www.usaha.org/xmlns/ecvi2".`

Namespace attributes may be used in either of two ways.  The most common is to define a prefix to represent the unique identifier of the namespace an prefix the element names of all elements in that namespace.

```
<foo:root xmlns:foo="http://www.foo.bar/foo">
	<foo:child>content</foo:child>
	<other:child xmlns:other="http://www.other.com">other content</other:child>
</foo:root>
```

This keeps the other so called *foreign* child element straight from the child defined in the foo namespace.

An element may also have a default namespace using the syntax: 

```
xmlns="namespaceURI".
< root xmlns ="http://www.foo.bar/foo">
	< child>content</child>
	<other:child xmlns:other="http://www.other.com">other content</other:child>
</root>
```

Because child elements inherit the default, all elements here that do not have prefixes are in the namespace `"http://www.foo.bar/foo"`.

The eCVI schema does not allow for any foreign elements.  The simplest and best implementation is to define a default namespace in the root, eCVI element: `<eCVI xmlns="http://www.usaha.org/xmlns/ecvi2" …>`

And then have no prefix on any element name.  The meaning is identical to defining a prefix and prefixing every element.  

This has the added benefit that simpler implementations that do not choose to use namespace awareness to validate that they are using the correct schema can simply ignore namespaces completely.  Some programming tools do this by default.

We have also seen many implementations that include the prefix for the schema namespace `xmlns:xs="http://www.w3.org/2001/XMLSchema"` in the eCVI element.  The prefix is, of course, never used because it is not allowed by the document schema.  This may have come from serial copying of root element information.  This does not change the meaning in any way at all but adds stray content that may confuse some simpler implementations.

### References
For more background on XML namespaces we recommend: [W3 Schools](https://www.w3schools.com/XML/xml_namespaces.asp)
