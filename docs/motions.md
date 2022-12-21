# Motions

## Horizontal Movements

| Motion    | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| `_`       | goes to beginning of line                                                     |
| `0`       | goes to beginning of line                                                     |
| `$`       | goes to the end of the line                                                   |
| ``        |                                                                               |
| `f<char>` | goes forward to specified char                                                |
| `t<char>` | goes up to specified char                                                     |
| `;`       | goes forward to next specified char, special motion has to be executed before |
| `;`       | goes back to next specified char, special motion has to be executed before    |
| `I`       | Beginning of line in insert mode                                              |
| `A`       | End of line in insert mode                                                    |

## Vertical Movements

| Motion       | Description                         |
| ------------ | ----------------------------------- |
| `{`          | paragraph backward                  |
| `}`          | paragraph forward                   |
| `C+d`        | jump half a page up                 |
| `C+u`        | jump half a page down               |
| `/<pattern>` | find pattern                        |
| `n`          | go to previous occurence of pattern |
| `N`          | go to next occurence of pattern     |
| `*`          | load word under cursor as pattern   |
| `?`          | inverted word under pattern         |

Tip: Vertical motion can be extended with zz in custom remaps to always be in the center of the screen
