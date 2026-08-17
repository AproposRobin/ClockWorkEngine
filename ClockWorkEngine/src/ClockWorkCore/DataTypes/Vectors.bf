namespace ClockWorkEngine.CoreMinimal;

struct SVector2D
{
    public float X;
    public float Y;

	public this()
	{
		X = 0.0f;
		Y = 0.0f;
	}

    public this(float X, float Y)
    {
        this.X = X;
        this.Y = Y;
    }

    public this(float Value)
    {
        this.X = Value;
        this.Y = Value;
    }
}

struct SVector3D
{
	public float X;
	public float Y;
	public float Z;

	public this()
	{
		X = 0.0f;
		Y = 0.0f;
		Z = 0.0f;
	}

	public this(float X, float Y, float Z)
	{
		this.X = X;
		this.Y = Y;
		this.Z = Z;
	}

	public this(float Value)
	{
		this.X = Value;
		this.Y = Value;
		this.Z = Value;
	}
}

struct SRotator
{
	
}

struct STransform
{

}