module Gosu
  @[Link("gosu")]
  lib ImageC
    fun create_image = Gosu_Image_create(filename : UInt8*, flags : UInt32) : UInt8*
    fun image_draw = Gosu_Image_draw(image : UInt8*, x : Float64, y : Float64, z : Float64,
                                     scale_x : Float64, scale_y : Float64, color : UInt32, flags : UInt32)
    fun destroy_image = Gosu_Image_destroy(image : UInt8*)
  end

  class Image
    def initialize(filename : String, flags : UInt32 = 0)
      @__image = ImageC.create_image(filename, flags)
    end

    def draw(x : Float64, y : Float64, z : Float64, scale_x : Float64 = 1.0, scale_y : Float64 = 1.0, color : UInt32 = 0xffffffff, flags : UInt32 = 0)
      ImageC.image_draw(@__image, x, y, z, scale_x, scale_y, color, flags)
    end

    def finalize
      ImageC.destroy_image(@__image)
    end
  end
end
