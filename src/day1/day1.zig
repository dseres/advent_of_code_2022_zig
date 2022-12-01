const std = @import("std");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn solve1(input: std.ArrayList(std.ArrayList(i32))) i32 {
    var sums = get_sums(input);
    std.sort.sort( i32, sums.items, {}, comptime std.sort.desc(i32));
    return sums.items[0];
}

pub fn solve2(input: std.ArrayList(std.ArrayList(i32))) i32 {
    var sums = get_sums(input);
    std.sort.sort( i32, sums.items, {}, comptime std.sort.desc(i32));
    return sums.items[0] + sums.items[1] + sums.items[2];
}

fn get_sums(input: std.ArrayList(std.ArrayList(i32))) std.ArrayList(i32) {
    var sums = std.ArrayList(i32).initCapacity(allocator, input.items.len) catch unreachable;
    for (input.items) |numbers| {
        sums.append(sum(numbers)) catch unreachable;
    }
    return sums;
}

fn sum(numbers: std.ArrayList(i32)) i32 {
    var s: i32 = 0;
    for (numbers.items) |num| {
        s += num;
    }
    return s;
}

const Solution = struct {
    first: i32,
    second: i32,
};

pub fn readInputAndSolve() Solution {
    const input = read_input_file();
    var parsed_input = parse_input(input);
    return .{ .first = solve1(parsed_input), .second = solve2(parsed_input) };
}

pub fn read_input_file() []const u8 {
    const file = open_file();
    defer file.close();
    return file.readToEndAlloc(allocator, 0xFFFF_FFFF) catch unreachable;
}

pub fn open_file() std.fs.File {
    const file = std.fs.cwd().openFile("input/input1.txt", .{}) catch |err| {
        std.log.err("Cannont open input file. {}", .{err});
        std.os.exit(1);
    };
    return file;
}

pub fn parse_input(input: anytype) std.ArrayList(std.ArrayList(i32)) {
    var list = std.ArrayList(std.ArrayList(i32)).init(allocator);
    var numbers = std.ArrayList(i32).init(allocator);
    var it = std.mem.split(u8, input, "\n");

    while (true) {
        if (it.next()) |line| {
            if (line.len > 0) {
                var n = parse_line(line);
                numbers.append(n) catch unreachable;
            } else {
                list.append(numbers) catch unreachable;
                numbers = std.ArrayList(i32).init(allocator);
            }
        } else {
            break;
        }
    }
    list.append(numbers) catch unreachable;
    return list;
}

pub fn parse_line(line: []const u8) i32 {
    var n = std.fmt.parseInt(i32, line, 10) catch |err| {
        std.log.err("Cannot parse input : {s}. {}", .{line, err});
        std.os.exit(3);
    };
    return n;
}

const test_input =
    \\1000
    \\2000
    \\3000
    \\
    \\4000
    \\
    \\5000
    \\6000
    \\
    \\7000
    \\8000
    \\9000
    \\
    \\10000
;

test "solution1 of test input " {
    var numbers = parse_input(test_input);
    var solution1 = solve1(numbers);
    try std.testing.expectEqual(solution1, 24000);

    var solution2 = solve2(numbers);
    try std.testing.expectEqual(solution2, 45000);
}

test "solution" {
    var solution = readInputAndSolve();
    try std.testing.expectEqual(solution.first, 66306);
    try std.testing.expectEqual(solution.second, 195292);
}
