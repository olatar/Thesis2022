import csv

with open('/Volumes/Samsung_T5/Danilo_data/IR/Danilo_true_annot.csv') as csv_file:
    csv_reader = csv.reader(csv_file)
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        else:
            spl = row[0].split('/')
            print(spl[-1])
