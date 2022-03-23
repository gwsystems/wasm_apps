#define stackWreckerSize 1024

int main()
{
	int stackWrecker[stackWreckerSize];

	for (int i = 0; i < stackWreckerSize; i++)
		stackWrecker[i] = i;

	return stackWrecker[stackWreckerSize - 1];
}
