// [[Rcpp::plugins(cpp11)]]
// [[Rcpp::depends(RcppParallel)]]
#include <Rcpp.h>
#include <RcppParallel.h>

using namespace Rcpp;
using namespace RcppParallel;

struct Transformer : public Worker {
  const RMatrix<double> input;
  RMatrix<double> output;
  Transformer(const NumericMatrix input, NumericMatrix output)
    : input(input), output(output) {}
  void operator()(std::size_t begin, std::size_t end) {
    std::transform(input.begin() + begin, input.begin() + end,
      output.begin() + begin, [](double x) {
        return 1 / (1 + x * x);
      });
  }
};

// [[Rcpp::export]]
NumericMatrix par_transform (NumericMatrix x) {
  NumericMatrix output(x.nrow(), x.ncol());
  Transformer transformer(x, output);
  parallelFor(0, x.length(), transformer);
  return output;
}
