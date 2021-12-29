# array.jl array of images
z = [ones(6,4), rand(6,4), rand(6,4), rand(6,4), rand(6,4)]
@isplot jim(z, yflip=false, title=L"test3 x^2_i")
@isplot jim(z, ncol=2)
@isplot jim(z, nrow=3)
@isplot jim(-3:2, -2:1, z) # zyflip
