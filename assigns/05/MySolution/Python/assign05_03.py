####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../05')
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-14: 30 points
BU CAS CS320-2023-Spring: Image Processing
"""
####################################################
import math
####################################################
import kervec
import imgvec
####################################################
from PIL import Image
####################################################

def load_color_image(filename):
    """
    Loads a color image from the given file and returns a dictionary
    representing that image.

    Invoked as, for example:
       i = load_color_image("test_images/cat.png")
    """
    with open(filename, "rb") as img_handle:
        img = Image.open(img_handle)
        img = img.convert("RGB")  # in case we were given a greyscale image
        img_data = img.getdata()
        pixels = list(img_data)
        width, height = img.size
        return imgvec.image(height, width, pixels)
    # return None

def save_color_image(image, filename, mode="PNG"):
    """
    Saves the given color image to disk or to a file-like object.  If filename
    is given as a string, the file type will be inferred from the given name.
    If filename is given as a file-like object, the file type will be
    determined by the "mode" parameter.
    """
    out = Image.new(mode="RGB", size=(image.width, image.height))
    out.putdata(image.pixlst)
    if isinstance(filename, str):
        out.save(filename)
    else:
        out.save(filename, mode)
    out.close()
    # return None

####################################################
#
# HX-2023-03-18:
# This one is incorrect:
# def grey_of_color(clr):
#     (r0, b1, g2) = clr
#     return round(0.299*r0+0.587*b1+0.114*g2)
def grey_of_color(clr):
    (rr, gg, bb) = clr
    return round(0.299*rr+0.587*gg+0.114*bb)
#
####################################################

def image_invert_grey(ximg):
    return imgvec.image_make_map(ximg, lambda pix: 255 - pix)
def image_invert_color(ximg):
    return imgvec.image_make_map(ximg, lambda clr: 255 - grey_of_color(clr))

####################################################
#
# towers = \
#     load_color_image("INPUT/towers.jpg")
balloons = \
    load_color_image("INPUT/balloons.png")
# balloons_invert = \
#     load_color_image("OUTPUT/balloons_invert.png")
# balloons_blurred = \
#     load_color_image("OUTPUT/balloons_blurred.png")
# balloons_energy = \
#     load_color_image("OUTPUT/balloons_energy.png")
#
####################################################
#
# save_color_image(image_invert_color(towers), "OUTPUT/towers_invert.png")
# save_color_image(image_invert_color(balloons), "OUTPUT/balloons_invert.png")
# save_color_image(image_edges_color(balloons), "OUTPUT/balloons_energy.png")
#
####################################################

def image_edges_grey(image):
    """
    This is an implementation of the Sobel operator.
    """
    krow = \
        kervec.kernel_make_pylist\
        (3, [-1, -2, -1, 0, 0, 0, 1, 2, 1])
    kcol = \
        kervec.kernel_make_pylist\
        (3, [-1, 0, 1, -2, 0, 2, -1, 0, 1])
    imgrow = \
        imgvec.image_kernel_correlate(image, krow, 'extend')
    imgcol = \
        imgvec.image_kernel_correlate(image, kcol, 'extend')
    imgres = \
        imgvec.image_make_z2map\
        (imgrow, imgcol, lambda x, y: math.sqrt(x*x + y*y))
    return imgvec.image_round_and_clip(imgres)

def image_edges_color(image):
    return image_edges_grey\
        (imgvec.image_make_map(image, lambda clr: 255 - grey_of_color(clr)))

####################################################

def image_blur_bbehav_grey(image, ksize, bbehav):
    ksize2 = ksize*ksize
    kernel = \
        kervec.kernel_make_pylist\
        (ksize, ksize2*[1.0/ksize2])
    return imgvec.image_round_and_clip\
        (imgvec.image_kernel_correlate(image, kernel, bbehav))

####################################################

def color_filter_from_greyscale_filter(filt):
    """
    Given a filter that takes a greyscale image as input and produces a
    greyscale image as output, returns a function that takes a color image as
    input and produces the filtered color image.
    """
    def image_filter(cimage):
        ww = cimage.width
        hh = cimage.height
        image0 = filt(imgvec.image_make_map(cimage, lambda clr: clr[0]))
        image1 = filt(imgvec.image_make_map(cimage, lambda clr: clr[1]))
        image2 = filt(imgvec.image_make_map(cimage, lambda clr: clr[2]))
        return imgvec.image_make_tuple\
            (hh, ww, \
             tuple(zip(image0.pixlst, image1.pixlst, image2.pixlst)))
    return lambda cimage: image_filter(cimage)

####################################################

def image_blur_bbehav_color(image, ksize, bbehav):
    return \
        color_filter_from_greyscale_filter\
        (lambda image: image_blur_bbehav_grey(image, ksize, bbehav))(image)

####################################################
# save_color_image\
#    (image_blur_bbehav_color(balloons, 5, 'extend'), "OUTPUT/balloons_blurred.png")
####################################################

def best_energy_pixel(energy,i, ww):
    if i < ww:
        energy[i] = (energy[i],2)

    elif i % ww == 0:
        center = energy[i] + energy[i-ww][0]
        right = energy[i] + energy[(i-ww)+1][0]

        if center < right:
            energy[i] = (center,0)
        else:
            energy[i] = (right,1)

    elif (i+1) % ww == 0:
        left = energy[i] + energy[(i-ww)-1][0]
        center = energy[i] + energy[i-ww][0]

        if center < left:
            energy[i] = (center,0)
        else:
            energy[i] = (left,-1)

    else:
        left = energy[i] + energy[(i-ww)-1][0]
        center = energy[i] + energy[i-ww][0]
        right = energy[i] + energy[(i-ww)+1][0]

        if center < right and center < left:
            energy[i] = (center,0)
        elif right < left:
            energy[i] = (right,1)
        else:
            energy[i] = (left,-1)

    return None

def make_seam_values(energy,ww,hh):
    int1_foreach(ww * hh, lambda i: best_energy_pixel(energy,i,ww))
    return energy


def remove_best_seam(image):
    ww = image.width
    hh = image.height
    size = ww * hh
    energy = image_edges_color(image)
    img_list = image.pixlst
    eng_list = list(energy.pixlst)

    seamed_e = make_seam_values(eng_list, ww,hh)
    last_row_min = seamed_e[size - ww][0]
    loc = size - ww
    for i in range(size - ww, size):
        print(seamed_e[i][0])
        if seamed_e[i][0] < last_row_min:
            last_row_min = seamed_e[i][0]
            loc = i

    # print(last_row_min)
    row = hh - 1
    to_be_removed = []

    while row >= 0:
        to_be_removed = pylist_append([loc % ww],to_be_removed)
        if seamed_e[loc][1] == 2:
            break
        elif seamed_e[loc][1] == -1:
            loc = (loc-ww)-1
        elif seamed_e[loc][1] == 0:
            loc = (loc-ww)
        else:
            loc = (loc-ww)+1
        row = row - 1

    # print(to_be_removed)
    image = imgvec.image(hh, ww-1, imgvec.image_i2filter_pylist(image, lambda i0, j0, _: to_be_removed[i0] != j0))
    # image = imgvec.image(hh, ww, imgvec.image_i2map_pylist\
    #             (image, lambda i0, j0, v0: v0 if to_be_removed[i0] != j0 else (255, 255, 255)))

    return image



def image_seam_carving_color(image, ncol):
    """
    Starting from the given image, use the seam carving technique to remove
    ncols (an integer) columns from the image. Returns a new image.
    """
    assert ncol < image.width
    energy = image_edges_color(image)

    # energy = imgvec.image(energy.height, energy.width, list(energy.pixlst))
    image = imgvec.image(image.height, image.width, list(image.pixlst))

    res = int1_foldleft(ncol, image, lambda r,_: remove_best_seam(r))

    return imgvec.image_make_pylist(res.height, res.width, res.pixlst)


####################################################
save_color_image(image_seam_carving_color(balloons, 1), "OUTPUT/balloons_seam_1.png")
####################################################
