# Define lable 'a' to iterate over modules
:a

# If the line module is matched ...
/Module/ {
    # Swap contents of hold and pattern buffer (current line)
    x

    # If the pattern buffer (former hold buffer)
    # contains something it is a module starting line.
    # Create and end tag out of it.
    s/.*Module (.*)/[End Module="\1"]/p

    # Get the current line back from hold buffer
    x

    h

    # Create a start module tag
    s/(--- )(.*)/[Start Module="\2"]/p

    # Create a label to iterate over messages
    :b

    # Get next line from input into pattern buffer
    # (Overwrite the pattern buffer)
    n

    # If it is not a module starting line ...
    /Module/! {

        # ... wrap it into the Message Content tag
        s/(\s*)(.*)/\1[Message Content="\2"]/p

        # and go on with the next line (step back to b)     
        bb
    }

    /Module/ {
        # if it is not the last line 
        # go on with the next module (step back to a)
        $!ba

        # on the last line ...

        # backup the current line in the hold buffer
        h

        # create start tag
        s/(--- )(.*)/[Start Module="\2"]/p

        # swap hold and pattern buffer
        x

        # create the end tag
        s/.*Module (.*)/[End Module="\1"]/p
    }
}