// Algorithms.cpp : Defines the entry point for the application.
//

#include "Algorithms.h"


int main(int argc, char **argv)
{
	const int size = 10;
	int* input = create_array_and_fill(size, true);
	//print(input, size);
	//insertion_sort(input, size);
	merge_sort(input, 0, size);
	//print(input, size);
	return EXIT_SUCCESS;
}
