class
    APPLICATION

create
    make

feature -- Initialization

    make
        local
            i: INTEGER
            e: separate ELF
            r: separate REINDEER
        do
            create santa.make (elves_batch_size, no_reindeers)

            -- launch reindeers
            from
                i := 1
            until
                i > no_reindeers
            loop
                create r.make (i, santa)
                launch_reindeer (r)
                i := i + 1
            end

            -- launch elves
            from
                i := 1
            until
                i > no_elves
            loop
                create e.make (i, no_failures, santa)
                launch_elf (e)
                i := i + 1
            end

            separate santa as s do
                s.open
            end
        end

feature {NONE}
    santa: separate SANTA
    no_reindeers: INTEGER = 9 -- Is fixed
    no_elves: INTEGER = 20 -- Could be anything
    elves_batch_size: INTEGER = 3
    no_failures: INTEGER = 2

    launch_elf (e: separate ELF)
        do
            e.live
        end

    launch_reindeer (r: separate REINDEER)
        do
            r.live
        end

end
