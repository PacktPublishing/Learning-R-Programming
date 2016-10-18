#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector diff_cpp(NumericVector x) {
  NumericVector res(x.size() - 1);
  for (int i = 0; i < x.size() - 1; i++) {
    res[i] = x[i + 1] - x[i];
  }
  return res;
}
