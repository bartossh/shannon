const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len != 2) {
        std.debug.print("Please provide single string input parameter for password entropy calculation.\n", .{});
        return;
    }
    const message = args[1];
    const bits = try shannon(message);
    std.debug.print("Given password entropy score {} bits: \n", .{bits});
    switch (bits) {
        0...10 => std.debug.print("Your password is a joke.\n", .{}),
        11...26 => std.debug.print("Your password can be cracked by your pet if you have one.\n", .{}),
        27...36 => std.debug.print("Your password is easy to crack.\n", .{}),
        37...62 => std.debug.print("Your password can be brute-forced fast, but its not very easy to guess.\n", .{}),
        63...72 => std.debug.print("Your password can be brute-forced relatively fast, but it can take more time.\n", .{}),
        73...74 => std.debug.print("Your password can be brute-forced with powerful machine.\n", .{}),
        else => std.debug.print("Your password is strong enough to be secure against brute force attack, check if it isn't leaked.\n", .{}),
    }
}

inline fn shannon(str: []const u8) !i64 {
    const allocator = std.heap.page_allocator;
    var frequency = std.AutoHashMap(u8, f64).init(
        allocator,
    );
    defer frequency.deinit();

    for (str) |c| {
        var n: f64 = 1.0;
        if (frequency.get(c)) |v| {
            n = v + 1;
        }
        try frequency.put(c, n);
    }

    var sum: f64 = 0;
    const divider: f64 = @floatFromInt(str.len);
    var iter = frequency.valueIterator();
    while (iter.next()) |v| {
        var f: f64 = @as(f64, v.*) / divider;
        sum += f * @log2(f);
    }

    sum = sum * -1;
    const multiplier: i64 = @intCast(str.len);
    const result: i64 = @as(i64, @intFromFloat(@ceil(sum))) * multiplier;
    return result;
}

test "simple test" {
    const expect = @import("std").testing.expect;
    const TestCase = struct {
        bits: i64,
        password: []const u8,
    };

    const testCases: [6]TestCase = [6]TestCase{ TestCase{
        .password = "123",
        .bits = 6,
    }, TestCase{
        .password = "password",
        .bits = 24,
    }, TestCase{
        .password = "myCa7I5a60d",
        .bits = 44,
    }, TestCase{
        .password = "m#P52s@ap$V",
        .bits = 44,
    }, TestCase{
        .password = "IthinkItIsVeryStrong",
        .bits = 80,
    }, TestCase{
        .password = "7k289be923hv934",
        .bits = 60,
    } };

    for (testCases) |tc| {
        const bits = try shannon(tc.password);
        std.debug.print("Tested [ {s} ] expected bits [ {d} ] received [ {d} ].\n", .{ tc.password, tc.bits, bits });
        try expect(bits == tc.bits);
    }
}
