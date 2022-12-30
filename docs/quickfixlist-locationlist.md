# Quickfix List and Location List

## Quickfix List

The quickfix list is useful for navigating to different locations in a project such as when reviewing linting warnings, compilation errors, or when conducting a project-wide search.

Many built-in commands (such as :vimgrep or :make) and third-party plugins leverage this list for displaying the results of an operation so that it may be quickly traversed using a set of quickfix commands.

### Commands

`:copen`

- Open the quickfix list window.

`:ccl or :cclose`

- Close the quickfix list window.

`:cnext or :cn`

- Go to the next item on the list.

`:cprev or :cp`

- Go to the previous item on the list.

`:cfirst`

- Go to the first item on the list.

`:clast`

- Go to the last item on the list.

`:cc <n>`

- Go to the nth item.

## Location list

The location list behaves just like the quickfix list except that it is local to the current window instead of being global to the Vim session. So if you have five open windows, you can have up to five location lists, but only one quickfix list.

Populating the location list is done in the exact same way as the quickfix list, except that the built-in commands are prefixed with l. For example: :lvimgrep, :lmake, :lgrep e.t.c. Some third-party plugins also place their output in the location list by default, although it’s usually configurable in case you prefer the quickfix list.

`:lopen`

- Open the location list window.

`:lcl or :lclose`

- Close the location list window.

`:lnext`

- Go to the next item on the list.

`:lprev`

- Go to the previous item on the list.

`:lfirst`

- Go to the first item on the list.

`:llast`

- Go to the last item on the list.

`:ll <n>`

- Go to the nth item.

## Navigationg older lists

Vim retains up to ten quickfix lists per session and ten location lists per window. If an operation creates a new list, the previous one is retained in the background until the limit is reached. This makes it possible to refer to an earlier list using the commands below:

`:colder or :col`

- Go to the previous quickfix list.

`:cnewer or :cnew`

- Go to the next quickfix list.

`:lolder or :lol`

- Go to the previous location list.

`:lnewer or :lnew`

- Go to the next location list.

Although a status message will be printed on the screen each time you switch between lists, it’s better to keep the quickfix or location list window open so that you can easily see the updated list.

### Arbitary commands

The `:cdo` command allows you to execute an arbitrary command of your choice for each entry on the quickfix list.
This is a powerful feature and provides the basis for the closest thing to a native project-wide search and replace in Vim.

For example, if you want to replace all instances of foo with bar in your project, you may conduct your search using `:grep` as follows:

Then you can use the `:cdo` command to execute the substitute command for each item in the quickfix list as shown below.
The update part causes the buffer to be written to disk after each modification.

While `:cdo` is doing its work, several files may be opened in Vim buffers.
To close each one, use the :cfdo command to execute `:bd`.
Instead of iterating over each entry in the list, `:cfdo` iterates over each referenced file in the list.

The location list equivalents for `:cdo` and `:cfdo` are — you guessed it — `:ldo` and `:lfdo`.

## Usage cases

```sh
file | row | col | error message
```

- search content within file/across files
- compile error
- test error
- linting error

### Lookup

- vimgrep
