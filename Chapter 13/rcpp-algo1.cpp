#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double algo1_cpp(int n) {
  double res = 0;
  for (double i = 1; i < n; i++) {
    res += 1 / (i * i);
  }
  return res;
}
