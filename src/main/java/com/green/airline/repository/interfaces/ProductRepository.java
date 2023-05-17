package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.MileageDto;
import com.green.airline.dto.ShopOrderDto;
import com.green.airline.dto.ShopProductDto;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.ShopOrder;
import com.green.airline.repository.model.ShopProduct;
import com.green.airline.repository.model.User;

@Mapper
public interface ProductRepository {

	public int insert(ShopProduct shopProduct);
	public List<ShopProduct> selectProductList();
	public ShopProduct selectById(int id);
	public int updateProduct(ShopProduct shopProduct);
	public int deleteProduct(int id);
	public int buyProduct(ShopOrder shopOrder);
	public int insertShopProductDto(ShopOrderDto  productDto);
	public int insertGifticonDto(GifticonDto gifticonDto);
	public ShopOrder selectShopOrder(String memberId);
	public Mileage selectMileage(String memberId);
	public int insertMileage(MileageDto mileageDto);
	public int updateShopProductDto(ShopProductDto  shopProductDto);
}
