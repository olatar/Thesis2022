import os
import matplotlib.pyplot as plt
from PIL import Image
import shutil

source_dir = "/Volumes/Samsung_T5/SSD_Masteroppgave/IR/source"
true_dir = "/Volumes/Samsung_T5/SSD_Masteroppgave/IR/true"
anomaly_dir = "/Volumes/Samsung_T5/SSD_Masteroppgave/IR/anomalies"

###################################
directory = os.fsencode(source_dir)

total_images = len(os.listdir(directory))
anomalous = 0
true = 0
false_inputs = []

for i, file in enumerate(os.listdir(directory)):
    filename = os.fsdecode(file)

    img = Image.open(os.path.join(source_dir, filename)).convert("L")
    #plt.imshow(img, cmap='gray_r', vmin=0, vmax=255) # inverse grayscale
    plt.imshow(img, cmap='gray', vmin=0, vmax=255)
    plt.title(str(i+1) + " - " + filename)
    plt.show()
    val = input("\nIs it anomalous? (y/n)\n")

    if val == "y":
        curr_path = os.path.join(source_dir, filename)
        anom_path = os.path.join(anomaly_dir, filename)
        shutil.move(curr_path, anom_path)

        true = true + 1
        print("Image {} anomalous and moved".format(filename))

    elif val == "n":
        curr_path = os.path.join(source_dir, filename)
        true_path = os.path.join(true_dir, filename)
        shutil.move(curr_path, true_path)

        anomalous = anomalous + 1
        print("Image {} fine".format(filename))
    else:
        false_inputs.append(filename)
        print("Input not valid for {}, added to list".format(filename))

print("\n---------------------------------------")
print("{} images were true, {} were anomalous, and were {} indecisive".format(true, anomalous,
                                                                              total_images - true - anomalous))
print("\n---------------------------------------")
print("Look through these files. They were given wrongful inputs from user:")
print(*false_inputs)