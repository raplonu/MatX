////////////////////////////////////////////////////////////////////////////////
// BSD 3-Clause License
//
// Copyright (c) 2021, NVIDIA Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
//    contributors may be used to endorse or promote products derived from
//    this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
/////////////////////////////////////////////////////////////////////////////////

#include <matx.h>

using namespace matx;

/**
 * MatX training assignment 2. This training goes through tensor operations that
 * were learned in the 02_operators notebook. Uncomment each verification block
 * as you go to ensure your solutions are correct.
 */

int main() {
  auto A = make_tensor<float>({2, 3});
  auto B = make_tensor<float>({2, 3});
  auto V = make_tensor<float>({3});

  cudaExecutor exec{};

  /****************************************************************************************************
   * Initialize tensor A with increasing values from 0.5 to 3.0 in steps of 0.4,
   *and tensor V from -1 to -3 in steps of -1.
   ****************************************************************************************************/

  /*** End editing ***/

  // Verify init is correct
  float step = 0.5;
  for (int row = 0; row < A.Size(0); row++) {
    for (int col = 0; col < A.Size(1); col++) {
      if (A(row, col) != step) {
        printf("Mismatch in A init view! actual = %f, expected = %f\n",
               A(row, col), step);
        exit(-1);
      }
      step += 0.5;
    }
  }

  for (int col = 0; col < V.Size(0); col++) {
    if (V(col) != (-1 + col * -1)) {
      printf("Mismatch in A init view! actual = %f, expected = %f\n", V(col),
             (float)(-1 + col * -1));
      exit(-1);
    }
  }

  print(A);
  print(V);
  printf("Init verification passed!\n");

  /****************************************************************************************************
   * Add 5.0 to all elements of A and store the results back in A
   ****************************************************************************************************/

  /*** End editing ***/

  exec.sync();

  step = 0.5;
  for (int row = 0; row < A.Size(0); row++) {
    for (int col = 0; col < A.Size(1); col++) {
      if (A(row, col) != (5.0 + step)) {
        printf("Mismatch in A sum view! actual = %f, expected = %f\n",
               A(row, col), 5.0 + step);
        exit(-1);
      }
      step += 0.5;
    }
  }

  print(A);
  printf("Sum verification passed!\n");

  /****************************************************************************************************
   * Clone V to match the dimensions of A, and subtract V from A. The results
   * should be stored in A
   *
   * https://devtech-compute.gitlab-master-pages.nvidia.com/matx/quickstart.html#increasing-dimensionality
   * https://devtech-compute.gitlab-master-pages.nvidia.com/matx/api/tensorview.html#_CPPv4I0_iEN4matx12tensor_tE
   *
   ****************************************************************************************************/
  /// auto tvs = ;
  /*** End editing. ***/

  // exec.sync();

  // step = 0.5;
  // for (int row = 0; row < A.Size(0); row++) {
  //   for (int col = 0; col < A.Size(1); col++) {
  //     if (A(row, col) != (5.0 + step - tvs(row, col))) {
  //       printf("Mismatch in A sub view! actual = %f, expected = %f\n", A(row,
  //       col), 5.0 + step - tvs(row, col)); exit(-1);
  //     }
  //     step += 0.5;
  //   }
  // }

  // print(A);
  // print(tvs);
  // printf("Clone verification passed!\n");

  /****************************************************************************************************
   * Raise the matrix A to the power of 2 and multiply the output by two. Next,
   * subtract the vector V from each row. Store the result in tensor B.
   *
   * https://devtech-compute.gitlab-master-pages.nvidia.com/matx/api/tensorops.html#_CPPv4N4matx3powE2Op2Op
   ****************************************************************************************************/

  /*** End editing ***/

  exec.sync();

  for (int row = 0; row < B.Size(0); row++) {
    for (int col = 0; col < B.Size(1); col++) {
      if (B(row, col) != powf(A(row, col), 2) * 2 - V(col)) {
        printf("Mismatch in B init view! actual = %f, expected = %f\n",
               B(row, col), powf(A(row, col), 2) * 2 - V(col));
        exit(-1);
      }
    }
  }

  print(B);
  printf("Mixed verification passed!\n");

  return 0;
}
