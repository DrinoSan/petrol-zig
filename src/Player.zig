const rl = @import("raylib");

pub const LoadError = error{
    TextureLoadFailed,
};

pub const Player_t = struct {
    name: []const u8,
    lifePoints: i32,
    speed: rl.Vector2,
    rec: rl.Rectangle,
    texture: rl.Texture2D,
    texturePosition: rl.Vector2,
    textureFrameRec: rl.Rectangle,
    framesCounter: i32,
    framesSpeed: i32,
    currentFrame: i32,

    pub fn init(self: *Player_t, playerName: []const u8) !void {
        self.name = playerName;
        self.lifePoints = 100;
        self.speed = rl.Vector2.init(0.1, 0.0);
        self.rec = rl.Rectangle.init(350.0, 281.0, 50.0, 50.0);
        self.texture = rl.loadTexture("resources/scarfy.png");
        self.texturePosition = rl.Vector2.init(351.0, 280.0);
        self.framesCounter = 1;
        self.framesSpeed = 9;
        self.currentFrame = 1;
        self.textureFrameRec = rl.Rectangle.init(0.0, 0.0, @floatFromInt(@divExact(self.texture.width, 6)), @as(f32, @floatFromInt(self.texture.height)));

        if (!rl.isTextureReady(self.texture)) {
            return LoadError.TextureLoadFailed; // Return the error if the texture is not ready
        }
    }

    // State updates
    pub fn playerUpdateState(self: *Player_t) void {
        if (self.framesCounter >= @divTrunc(60, self.framesSpeed)) {
            self.framesCounter = 0;
            self.currentFrame += 1;

            if (self.currentFrame > 5)
                self.currentFrame = 0;

            self.textureFrameRec.x =
                @as(f32, @floatFromInt(self.currentFrame)) * @as(f32, @floatFromInt(@divExact(self.texture.width, 6)));
        }

        // Control frames speed
        if (rl.isKeyDown(rl.KeyboardKey.key_right)) {
            self.texturePosition.x += 5;
            self.framesCounter += 1;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_left)) {
            self.texturePosition.x -= 5;
            self.framesCounter += 1;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_up)) {
            self.texturePosition.y -= 5;
            self.framesCounter += 1;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_down)) {
            self.texturePosition.y += 5;
            self.framesCounter += 1;
        }
    }

    // Draw
    pub fn playerDrawPlayer(self: *Player_t) void {
        rl.drawTextureRec(self.texture, self.textureFrameRec, self.texturePosition, rl.Color.white); // Draw part of the texture
    }
};
