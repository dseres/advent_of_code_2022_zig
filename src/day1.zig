const std = @import("std");

pub fn solve1() !i32 {
    _ = try read_input_file();
    return 0;
}

pub fn solve2() !i32 {
    return 0;
}

pub fn read_input_file() ![]const u8 {
    const file = try std.fs.cwd().openFile("input/input1.txt", .{});
    defer file.close();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var bytes_read = try file.readToEndAlloc(gpa.allocator(), 0xFFFF_FFFF);
    return bytes_read;
}

test "read_input_file" {
    var input = read_input_file() catch "";
    try std.testing.expect(std.mem.eql(u8, input, "Hello world!\r\n"));
}

test "solution1" {
    try std.testing.expectEqual(solve1(), 0);
}

test "solution2" {
    try std.testing.expectEqual(solve2(), 0);
}
