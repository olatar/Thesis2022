import os
import matplotlib.pyplot as plt
from PIL import Image
import shutil

source_dir = "/Volumes/Samsung_T5/SSD_Masteroppgave/IR/True"

###################################
directory = os.fsencode(source_dir)

total_images = len(os.listdir(directory))
anomalous = 0
true = 0
false_inputs = []

for i, file in enumerate(os.listdir(directory)):
    filename = os.fsdecode(file)

    filename_list = filename.split('.')
    suffix = '.' + filename_list[-1]
    filename_list = filename_list[0]
    filename_list = filename_list.split(' ')
    number = filename_list[0]

    new_filename = number + suffix

    if len(filename_list) > 1:

        old_path = os.path.join(source_dir, filename)
        new_path = os.path.join(source_dir, new_filename)

        print(old_path)
        print(new_path)
        shutil.move(old_path, new_path)

