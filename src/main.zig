const std = @import("std");
const day1 = @import("day1.zig");

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
     try stdout.print("Solution of day1: {d} {d}\n", .{day1.solve1(), day1.solve2()});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
