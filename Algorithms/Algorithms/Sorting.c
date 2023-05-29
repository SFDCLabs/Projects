#include "Sorting.h"

void insertion_sort(int *input, int size) {
	if (!input || size <= 1)
		return;
	for (int i = 1; i < size; i++) {
		int key = *(input + i);
		int j = i - 1;
		while (j >= 0 && *(input + j) > key) {
			*(input + j + 1) = *(input + j);
			j--;
		}
		*(input + j + 1) = key;
	}
}

void merge(int* input, int start, int mid, int end) {
	int leftSize = mid - start + 1;
	int rightSize = end - mid;

	int leftArray[leftSize], rightArray[rightSize];
	for (int i = 0; i < leftSize; i++)
		leftArray[i] = input[ start + i];
	for (int i = 0; i < rightSize; i++)
		rightArray[i] = input[mid + i + 1];
	print(leftArray, leftSize);
	printf("\n");
	print(rightArray, rightSize);
	printf("\n");
	printf("----------------");
	printf("\n");
}

void merge_sort(int *input, int start, int end) {
	if (!input || start >= end || start < 0 || end <= start || end > INT_MAX)
		return;
	int mid = (start + end) / 2;
	merge_sort(input, start, mid);
	merge_sort(input, mid + 1, end);
	merge(input, start, mid, end);
}