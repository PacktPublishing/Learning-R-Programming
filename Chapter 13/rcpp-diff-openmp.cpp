// [[Rcpp::plugins(openmp)]]
#include <omp.h>
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector diff_cpp_omp(NumericVector x) {
  omp_set_num_threads(3);
  NumericVector res(x.size() - 1);
#pragma omp parallel for 
  for (int i = 0; i < x.size() - 1; i++) {
    res[i] = x[i + 1] - x[i];
  }
  return res;
}
