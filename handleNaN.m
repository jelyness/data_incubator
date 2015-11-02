% handle missing values NaN
function data=handleNaN(data)

ind=find(isnan(data)==0);
for i=1:length(ind)
    if i==length(ind)
       data((ind(i)+1):length(data))=data(ind(i));
    else        
        data((ind(i)+1):(ind(i+1)-1))=data(ind(i));
    end
end
