const std = @import("std");
const day1 = @import("day1/day1.zig");

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Solution of day1: {d} {d}\n",  day1.readInputAndSolve());
}
