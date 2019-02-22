int main()
{

	int arr[2][2];
	int brr[2][2];
	int i,j;
	for(i=0;i<2;i++)
	{
		for(j=0;j<2;j++)
		{
			arr[i][j] = i+j;
			brr[i][j] = i-j;
		}
	}
	
	int crr[2][2];
	for(i=0;i<2;i++)
	{
		for(j=0;j<2;j++)
		{
			crr[i][j] = arr[i][j] + brr[i][j] ;
		}
	}


}
