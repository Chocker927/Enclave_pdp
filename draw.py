import matplotlib.pyplot as plt
import os

def draw_pic(filename):
    pic_name=filename.split(".")[0]+".png"
    with open(filename,"r") as f:
        data=f.readlines()
        y=[]
        for i in data:
            s=i.split(" ")
            y.append(float(s[5]))
        x=[2**i for i in range(0,11)]
        plt.figure(figsize=(10,6))
        plt.plot(x,y,"r-")
        plt.xlabel("Size of data(MB)")
        plt.ylabel("Cost time(sec)")
        plt.title(data[0].split(" ")[0]+" different size of file cost time")
        plt.savefig(pic_name,dpi=400)

if __name__=="__main__":
    logs=os.listdir(os.getcwd())
    for i in logs:
        if os.path.splitext(i)[1] == ".log":
            draw_pic(i)