const rl = @import("raylib");
const pl = @import("Player.zig");

var player: pl.Player_t = undefined;
const screenWidth = 800;
const screenHeight = 600;

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    rl.initWindow(screenWidth, screenHeight, "Drive and Fight zombies");
    defer rl.closeWindow(); // Close window and OpenGL context

    try InitGame();

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        UpdateDrawFrame();
        //----------------------------------------------------------------------------------
    }
}

//-----------------------------------------------------------------------------
fn InitGame() !void {
    player.init("Sandrino") catch |err| {
        rl.traceLog(rl.TraceLogLevel.log_error, "Player initialization failed, aborting program");
        UnloadGame();
        return err;
    };
}

//-----------------------------------------------------------------------------
// Update game (one frame)
fn UpdateGame() void {
    // Player update stuff
    player.playerUpdateState();
}

//-----------------------------------------------------------------------------
fn DrawGame() void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.ray_white);

    rl.drawText("Petrol", screenWidth / 2 - @divTrunc(rl.measureText("Petrol", 40), 2), @divTrunc(screenHeight, 2) - 40, 40, rl.Color.black);

    // Player draw stuff only sprite stuff
    player.playerDrawPlayer();

    rl.drawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, rl.Color.gray);
}

//-----------------------------------------------------------------------------
fn UnloadGame() void {
    rl.unloadTexture(player.texture);
}

//-----------------------------------------------------------------------------
fn UpdateDrawFrame() void {
    UpdateGame();
    DrawGame();
}
