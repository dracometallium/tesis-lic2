#pragma omp parallel num_threads(3)
{
	printf("Paralelo\n");
#pragma omp critical (regionCritica)
	printf("Exclusión mutua\n");
}
#pragma omp parallel sections num_threads(3)
{
#pragma omp serction
	printf("Sección 1\n");
#pragma omp serction
	printf("Sección 2\n");
#pragma omp serction
	printf("Sección 3\n");
}
#pragma omp parallel num_threads(3)
#pragma omp master
{
#pragma omp task
	printf("Tarea 1\n");
#pragma omp task
	printf("Tarea 2\n");
#pragma omp tast wait
#pragma omp task
	printf("Tarea 3\n");
}
