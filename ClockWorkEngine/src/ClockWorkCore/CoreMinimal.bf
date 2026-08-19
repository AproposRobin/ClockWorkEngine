namespace ClockWorkEngine.CoreMinimal
{
	/**
	DataTypes
	*/
	//Vectors & Transforms

	struct CVector2D : this(float X, float Y);

	struct CVector3D : this(float X, float Y, float Z);

	struct CRotator : this(float Pitch, float Yaw, float Roll);

	struct CTransform : this(CVector3D Location, CRotator Rotation, CVector3D Scale);
}
