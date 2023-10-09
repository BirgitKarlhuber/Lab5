
test_that("function rejects errounous input", {
  expect_error(request_data <- request_API("at-3", "2016-01-01"))
  expect_error(request_data <- request_API("world-2","01-01-2016"))
  expect_error(request_data <- request_API("world-2","01-2016"))
  expect_error(request_data <- request_API("world-2","2016-31-01"))
  expect_error(request_data <- request_API("world-2","2016-01-44"))
  expect_error(request_data <- request_API("world-2","2016/01/01"))
})

test_that("outputs are correct", {
  expect_equal(round(request_API("world-2", "2016-01-01")$geometry[[1]][[1]][[1]][1:3,],2),
               round(rbind(c(-58.17262, 6.812218),c(-57.96667, 6.775418), c(-57.51919,6.270764)),2))
  expect_equal(length(request_API("ch-8", "2000-01-01")$id), 2613)
})

