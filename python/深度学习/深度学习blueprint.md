//*机器学习classification*
supervised learning
non-supervised learning
half-supervised learning
reinforce learning
## 1. 深度网络框架
无监督预训练网络
卷积神经网络
循环神经网络
递归神经网络
## 2. characteristica
	1. 比机器学习的前馈网络神经元更复杂
	2. 网络层间连接更复杂
	3. 需要大量更多算力
	4. ***可自动提取特征***
## 3. [传统ML学习算法](http://t.csdn.cn/18gYt)
[1. 优化-反向传播](http://t.csdn.cn/ro9K8)
//[梯度下降算法](http://t.csdn.cn/iVYcM)
//[梯度(给忘掉梯度含义的我自己看的)](https://baike.baidu.com/item/%E6%A2%AF%E5%BA%A6/13014729)
-进阶:随机梯度下降
//随机取xi而不是hθ(x=z)作为梯度下降参数
[***logistic Regression***](http://t.csdn.cn/THoi5)
是一种广义的线性回归模型,
估计x的分布
//z=θ0x0+θ1x1+θ2x2+...+θixi+...+θnxn(x0=1)=θ0+θ1x1+θ2x2+...+θixi+...+θnxn=θTx,
[2. 正则化与学习律衰减](http://t.csdn.cn/CYl3B)
[实操](http://t.csdn.cn/RFjgc)
**正则化的方式**
1.  权重正则化 M*x^2 
2.  Dropout 正则化，like |yi-f(xi)|>t, drop f(xi) 
3.  批量正则化
4.  正则初始化 
**activate function**
1. sigmod()
2. ...
**损失函数**——selfdefine
**优化器**
1. SAG
2. BP
## 4. 深度特征
1. 卷积层