namespace ClockWorkEngine.CoreMinimal;

struct SVector2D : this(float X, float Y);

struct SVector3D : this(float X, float Y, float Z);

struct SRotator : this(float Pitch, float Yaw, float Roll);

struct STransform : this(SVector3D Location, SRotator Rotation, SVector3D Scale);
