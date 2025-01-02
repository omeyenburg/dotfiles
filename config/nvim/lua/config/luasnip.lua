local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Enable the autosnippet type
ls.config.setup({ enable_autosnippets = true })

-- LaTeX Snippets
ls.add_snippets('tex', {
    -- Inline math
    s({ trig = 'mk', snippetType = 'autosnippet' }, {
        t '$',
        i(1, ''),
        t '$',
        i(2, ''),
    }),

    -- Display math
    s('display', {
        t '$$',
        i(1, 'expression'),
        t '$$',
    }),

    -- Fraction
    s('frac', {
        t '\\frac{',
        i(1, 'numerator'),
        t '}{',
        i(2, 'denominator'),
        t '}',
    }),

    -- Display fraction
    s('displayfrac', {
        t '\\[',
        t '\\frac{',
        i(1, 'numerator'),
        t '}{',
        i(2, 'denominator'),
        t '}',
        t '\\]',
    }),

    -- Equation
    s('eq', {
        t '\\begin{equation}',
        t '\n',
        i(1, 'equation'),
        t '\n',
        t '\\end{equation}',
    }),

    -- Align
    s('align', {
        t '\\begin{align}',
        t '\n',
        i(1, 'equation'),
        t '\n',
        i(2, 'equation'),
        t '\n',
        t '\\end{align}',
    }),

    -- Matrix
    s('matrix', {
        t '\\begin{matrix}',
        t '\n',
        i(1, 'a_{11}'),
        t ' & ',
        i(2, 'a_{12}'),
        t ' \\\\',
        i(3, 'a_{21}'),
        t ' & ',
        i(4, 'a_{22}'),
        t '\n',
        t '\\end{matrix}',
    }),

    -- Summation
    s('sum', {
        t '\\sum_{',
        i(1, 'i=1'),
        t '}^{',
        i(2, 'n'),
        t '}',
        i(3, 'f(i)'),
    }),

    -- Integral
    s('int', {
        t '\\int_{',
        i(1, 'a'),
        t '}^{',
        i(2, 'b'),
        t '}',
        i(3, 'f(x)'),
    }),

    -- Section
    s('sec', {
        t '\\section{',
        i(1, 'Section Title'),
        t '}',
    }),

    -- Figure
    s('fig', {
        t '\\begin{figure}[htbp]',
        t '\n',
        t '\\centering',
        t '\n',
        i(1, 'image'),
        t '\n',
        t '\\caption{',
        i(2, 'Caption'),
        t '}',
        t '\n',
        t '\\end{figure}',
    }),
})
