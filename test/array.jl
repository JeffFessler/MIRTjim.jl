# array.jl array of images
z = [ones(6,4), rand(6,4), rand(6,4), rand(6,4), rand(6,4)]
@isplot jim(z, yflip=false, title=L"test3 x^2_i")
@isplot jim(z, ncol=2)
@isplot jim(z, nrow=3)
@isplot jim(-3:2, -2:1, z) # zyflip

z = [reshape(1:12,3,4), ones(4,5)]
@test MIRTjim._maxgood(z) == 12
@test MIRTjim._mingood(z) == 1
