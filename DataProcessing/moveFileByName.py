import os
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import shutil

source_dir = "/Volumes/Samsung_T5/Haak_data/Flight1/_Unidentified"
true_dir = "/Volumes/Samsung_T5/Haak_data/Flight1/_True"
anomaly_land_dir = "/Volumes/Samsung_T5/Haak_data/Flight1/_Anomalies_land"
anomaly_object_dir = "/Volumes/Samsung_T5/Haak_data/Flight1/_Anomalies_object"

###################################

Type = 'a-l'
choice = ''

while True:

    ######################### ANOMALY LAND ################################################
    # If image to anomaly pile
    if Type == 'a-l':  # anomaly
        choice = input('In ANOMALY LAND, select file/switch mode (true: t, quit: q): ')

        if choice == 't':
            Type = choice
            print('Changing type to True mode')
        elif choice == 'a-o':
            Type = choice
            print('Changing type to Anomaly Object mode')
        elif choice == 'q':
            print('Process quit!')
            break
        else:

            list_choices = list(map(int, choice.split('-')))
            if len(list_choices) > 1:
                list_choices = np.arange(list_choices[0], list_choices[1] + 1)
                print(list_choices)

            for ch in list_choices:
                filename = str('%05d' % int(ch)) + '.png'
                curr_path = os.path.join(source_dir, filename)
                anom_path = os.path.join(anomaly_land_dir, filename)
                if not os.path.exists(curr_path):
                    print('Can\'t find proposed filename: ' + filename)
                else:
                    shutil.move(curr_path, anom_path)
                    print('Added ' + filename + ' to ANOMALY LAND pile')

    ######################### ANOMALY OBJECT ################################################
    # If image to anomaly pile
    if Type == 'a-o':  # anomaly
        choice = input('In ANOMALY OBJECT, select file/switch mode (true: t, quit: q): ')

        if choice == 't':
            Type = choice
            print('Changing type to True mode')
        elif choice == 'a-l':
            Type = choice
            print('Changing type to Anomaly Land mode')
        elif choice == 'q':
            print('Process quit!')
            break
        else:

            list_choices = list(map(int, choice.split('-')))
            if len(list_choices) > 1:
                list_choices = np.arange(list_choices[0], list_choices[1] + 1)
                print(list_choices)

            for ch in list_choices:
                filename = str('%05d' % int(ch)) + '.png'
                curr_path = os.path.join(source_dir, filename)
                anom_path = os.path.join(anomaly_object_dir, filename)
                if not os.path.exists(curr_path):
                    print('Can\'t find proposed filename: ' + filename)
                else:
                    shutil.move(curr_path, anom_path)
                    print('Added ' + filename + ' to ANOMALY OBJECT pile')

    ######################### TRUE ################################################
    # If image to true pile
    if Type == 't':  # true
        choice = input('In TRUE MODE, select file/switch mode (anomaly (land/object): a-l/a-o, quit: q): ')

        if choice == 'a-l':
            Type = choice
            print('Changing type to Anomaly Land mode')
        elif choice == 'a-o':
            Type = choice
            print('Changing type to Anomaly Object mode')
        elif choice == 'q':
            print('Process quit!')
            break
        else:

            list_choices = list(map(int,choice.split('-')))
            if len(list_choices) > 1:
                list_choices = np.arange(list_choices[0], list_choices[1]+1)
                print(list_choices)


            for ch in list_choices:
                filename = str('%05d' % int(ch)) + '.png'
                curr_path = os.path.join(source_dir, filename)
                true_path = os.path.join(true_dir, filename)

                if not os.path.exists(curr_path):
                    print('Can\'t find proposed filename: ' + filename)
                else:
                    shutil.move(curr_path, true_path)
                    print('Added ' + filename + ' to TRUE pile')
