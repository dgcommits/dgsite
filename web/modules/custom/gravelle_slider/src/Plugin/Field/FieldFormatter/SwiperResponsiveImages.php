<?php

declare(strict_types=1);

namespace Drupal\gravelle_slider\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\Attribute\FieldFormatter;
use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\responsive_image\Plugin\Field\FieldFormatter\ResponsiveImageFormatter;
use Drupal\swiper_formatter\Service\SwiperInterface;
use Drupal\swiper_formatter\SwiperFormatterTrait;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Plugin implementation of the 'Swiper responsive images' formatter.
 */
#[FieldFormatter(
  id: 'swiper_formatter_responsive_image',
  label: new TranslatableMarkup('Swiper responsive images'),
  field_types: [
    'image',
  ]
)]
class SwiperResponsiveImages extends ResponsiveImageFormatter {

  use SwiperFormatterTrait;

  /**
   * Swiper formatter base service.
   *
   * @var \Drupal\swiper_formatter\Service\SwiperInterface
   */
  protected SwiperInterface $swiperBase;

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition): self {
    /** @var self $instance */
    $instance = parent::create($container, $configuration, $plugin_id, $plugin_definition);
    $instance->swiperBase = $container->get('swiper_formatter.base');
    return $instance;
  }

  /**
   * {@inheritdoc}
   */
  public static function defaultSettings(): array {
    // Inherit responsive image settings, add Swiper defaults.
    return parent::defaultSettings() + SwiperInterface::DEFAULT_SETTINGS;
  }

  /**
   * {@inheritdoc}
   */
  public function viewElements(FieldItemListInterface $items, $langcode): array {
    $output = parent::viewElements($items, $langcode);
    if (!$items->count()) {
      return $output;
    }
    $entity = $items->getEntity();
    $data = $this->swiperBase->processElements($this->fieldDefinition, $entity, $this->getSettings(), $output);
    foreach ($data['output'] as $delta => &$item) {
      // Caption support (optional). For image fields, can use 'title' or 'alt'.
      $caption = $data['settings']['caption'] ?? NULL;
      $this->swiperBase->getCaption($item, $caption, $entity, $delta);
    }
    return $this->swiperBase->renderSwiper($entity, $data['output'], $data['settings']);
  }

}

