///usr/bin/env jbang "$0" "$@" ; exit $?

import static java.lang.System.*;
import java.lang.ClassLoader;
import java.io.*;
import java.util.*;
//Arrays;
import java.util.stream.Collectors;

public class AoC_4 {
    public static void main(String... args) {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader("input"));
            String line = br.readLine();
            int countContained = 0;
            int countOverlapping = 0;

            while (line != null) {
                List<Integer> elf1 = Arrays.stream(line.split(",")[0].split("-")).map(Integer::parseInt).collect(Collectors.toList());
                List<Integer> elf2 = Arrays.stream(line.split(",")[1].split("-")).map(Integer::parseInt).collect(Collectors.toList());

                if (elf1.get(0)<=elf2.get(0) && elf1.get(1) >= elf2.get(1) || elf1.get(0)>=elf2.get(0) && elf1.get(1) <= elf2.get(1)) {
                    countContained++;
                }
                if (elf1.get(0)>=elf2.get(0) && elf1.get(0) <= elf2.get(1) ||
                    elf1.get(1)>=elf2.get(0) && elf1.get(0) < elf2.get(1)) {
                    countOverlapping++;
                }

                line = br.readLine();
            }
            out.println(countContained);
            out.println(countOverlapping);

            br.close();
        } catch(FileNotFoundException e) {
            out.println(e);
        } catch(IOException e) {
            out.println(e);  
        }
    }
}
