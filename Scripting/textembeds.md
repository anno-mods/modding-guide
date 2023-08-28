# Excourse: Embedding Text

The Game supports embedding Text from a Textsource. Every variable inside `TextSources.TextSourceRoots` can be embedded. The Embed does is unable to use function calls, only variables. 

For our example, we are gonna embed the current balance as a text for Asset `2001000000`. The variable in the API for the current balance is: `ts.Money.TotalIncome`.
We
- omit the `ts.` 
- replace the dots with whitespace
- wrap all of it in angular brakcets brackets `[]`
  
And end up with `[Money TotalIncome]`

> Sometimes, you have the issue that a variable is not in the API, only it's getters and setters. In this case, just omit the `Get`/`Set` part and use the remaining name as Variable name, it's gonna work. 

```XML
<ModOp Type = "add" Path = "/TextExport/Texts">
    <Text>
        <GUID>2001000000</GUID>
        <Text>[Money TotalIncome]</Text>
    </Text>
</ModOp>
```

## Formatting

Now, you might have noticed that this results in our current balance being printed as an unformatted number like `-1000000`.
To get a nicely formatted text, you can use `TextSourceFormatting` as defined in Asset `100274`

What you do is adding a `formatidentifier` like `balance10K` to your text with the `>>` formatting operator after the value. 

Example: `[Money TotalIncome >> balance10K]`

And because `>` is an invalid character, you gotta escape it. 

```XML
<ModOp Type = "add" Path = "/TextExport/Texts">
    <Text>
        <GUID>2001000000</GUID>
        <Text>[Money TotalIncome &gt;&gt; balance10K]</Text>
    </Text>
</ModOp>
```