#include "Common.h"

int* create_array_and_fill(int size, bool is_fill) {
	int* result = NULL;
	if (size <= 0)
		return result;
	result = (int*)calloc (size, sizeof(int));
	if (result) {
		if (is_fill) {
			for (int i = 0; i < size; i++) {
				*(result + i) = (rand() % size) + 1;
			}
		}
	}
	else {
		printf("MemoryOverflow Error: Fail to create int array of size %d\n", size);
	}
	return result;
}

void print(int *input, int size) {
	if (!input || size <= 0)
		return;
	for (int i = 0; i < size; i++) {
		printf("%d\t", *(input + i));
	}
	printf("\n");
}