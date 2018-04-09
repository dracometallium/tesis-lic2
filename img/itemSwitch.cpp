int main(){
    //Código de inicialización
    continuar=true;
#pragma omp parallel sections num_threads(3)
    {
#pragma omp section
            generaciónDeCuadros(fuente, pilaCuadros, &continuar);
#pragma omp section
           generaciónDeTareasDeFragmentaciónDeCuadros
                (NHilos, NPartes, pilaCuadros, &continuar);
#pragma omp section
        {
                esperarSeñalFin();
                continuar=false;
        }
    }
    //Código de finalización
    return 0;
}

int generaciónDeTareasDeFragmentaciónDeCuadros
        (NHilos, NPartes, pilaCuadros, continuar)
{
    hilosLibres = NHilos;
#pragma omp parallel num_threads(NHilos + 1) default(shared)
#pragma omp master
    while(*continuar) {
        cuadro = NULL;
        if ((pilaCuadros->cantidad() > 0) && (hilosLibres > 0)) {
#pragma omp critical (RingStack)
                cuadro = pilaCuadros->siguiente();
        }
        if (cuadro != NULL) {
#pragma omp atomic
            hilosLibres--;
#pragma omp task firstprivate(cuadro) default(shared)
            if (*continuar) {
                p = fraccionar(cuadro, NPartes);
                deltaHilos = NPartes - 1;
#pragma omp atomic
                hilosLibres = hilosLibres - deltaHilos;
                for (t = 0; t < NPartes; t++)
#pragma omp task firstprivate(t) default(shared)
                {
                    for (i = 0; i < pilas->cantidad(); i++) {
                        RestaurarCuadro(p[t]);
                        pilas[i]->procesar(p[t]);
                    }
                    borrarParte(p[t]);
#pragma omp atomic
                    hilosLibres++;
                }
            }
        }
    }
#pragma omp taskwait
    return 0;
}
