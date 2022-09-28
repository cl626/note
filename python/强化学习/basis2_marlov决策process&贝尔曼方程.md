## content
1. 概率转移矩阵(s',r,s,a关系)
2. 汇报与分幕(处理远近收益)
3. 贝尔曼方程(条件概率的应用)


## define转移概率矩阵
![76e40cd9e89342316126802420b47fe5.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/724121122aaf4fb3bd4ae1e113d61b9e.png?t=1656560157005)

![d5eae7439ad5e34060caa3bfe58d68ef.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/324d20c85fd445a79ade745ebf74d191.png?t=1656660679878)
//St与At

### 可求得其他信息

![e493ab0d96326e89a79cd894be376cb6.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/dfadea2b152945ddbccd7939bed389f9.png?t=1656660793117)

## 回报与分幕=根号2

**折扣率**——加权收益，短期相对重要
![af1d31e4adfda5769f9ed13325472b5a.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/0e558276b7f546b188b2983966f119f2.png?t=1656661215538)
![afa53f39955574ee61395ddb40a3e048.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/0600e22762044bb5a9f67ef72626b47f.png?t=1656677474699)

### vΠ的贝尔曼方程

![37db09e4518406763e0556cb6200ebff.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/7b96a5bb90cc4ca4b51e1a2b21ef631e.png?t=1656680300184)
![4f0261d2773f1d227cc176ce2fe84862.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/a4541235c2c442978f0d3ab9daa9a74f.png?t=1656680437012)

![9f31398b8fc428ed534e3a584ed6dd6f.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/d9491e9f62ad4092bf1c79340ccd6c4c.png?t=1656681330160)
分幕式？

![b692b7b417b2302fe9725ef8c4d1b37c.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/8ab3bd0e1431496b9673c57a0f1ac3bc.png?t=1656682113157)
而马尔可夫过程s',a'由s,a mutual determine
**要命的细节**
![38ff2e1aa547054bae260cdce3210952.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/bc7b9ae3240d4f58b4766d772022f69f.png?t=1656684922501)
**贝尔曼最优方程**
**Attention!:r=r(s,a)**
![a65cba5aaa99a2e542618b80f78fa663.png](file:///C:/Users/%E8%81%94%E6%83%B3/.config/joplin-desktop/resources/42d5f4388f3a408e8c7c05e5ec615ad8.png?t=1656685363594)
max是否应该在E外面？