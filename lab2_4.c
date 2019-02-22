int Op(int n)
{
	int i;
	int result = 1;
	if(n<=1)
		 result = -1;
	else
	{
		for(i=2;i<=n/2;i++)
		{
			if(n%i==0)
			{
				result = -1;
				break;
			}
		}
	}	
	
	if(result==1)
		return result;
	else
	{
		if(n%2==0)
			return 2;
		else return 3;
	}
}


int main()
{
	int num=33,res;
	switch(Op(num))
	{
		case 1:
			{
				if(num==2)
					res = num;
				else
				{	
					res = num+1;
				}
				break;
			}
		case 2:
			{
				res = num+1;
				break;
			}
		case 3:
			{
				int res1 = num-1,res2 = num-1;
				while(Op(res1)!=1 && res1>1)
				{
					res1--;
				}
				while(Op(res2)!=1)
				{
					res2++;
				}
				if((num-res1)<(res2-num))
					res = res1;
				else res = res2;
				break;
			}
	}

}
