import os, shutil

# defining path, file and folder names

path = r"C:\Users\bdani\Downloads/"
file_name = os.listdir(path)
folder_names = ['Exes', 'Images', 'Docs']

#executing moves with statements

for file in file_name:
    #if ".exe" in file and not os.path.exists(path + 'Exes/' + file):
        #shutil.move(path + file, path + 'Exes/' + file)
    if ".png" in file and not os.path.exists(path + 'images/' + file):
        shutil.move(path + file, path + 'images/' + file)
    #if ".png" and ".mp4" and ".jpg" in file and not os.path.exists(path + 'Images/' + file):
        #shutil.move(path + file, path + 'Images/' + file)